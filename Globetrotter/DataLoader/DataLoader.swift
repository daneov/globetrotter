//
//  DataLoader.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 10/10/2024.
//

import Combine
import Foundation

protocol DataLoader {
    associatedtype Model: Decodable

    var httpClient: HTTPClient { get }
    var source: URL { get }

    func fetch() async throws -> Model
}

// MARK: Default implementation

enum DataLoaderError: Error {
    case noData
    case notFound
}

extension DataLoader {
    func fetch() async throws -> Model {
        let (data, response) = try await httpClient.request(.init(url: source))

        guard response.statusCode == 200 else {
            if response.statusCode >= 400, response.statusCode < 500 {
                throw DataLoaderError.notFound
            }

            throw URLError(.badServerResponse)
        }
        guard let data = data else {
            throw DataLoaderError.noData
        }

        return try JSONDecoder().decode(Model.self, from: data)
    }
}

// MARK: Combine compatibility

extension DataLoader {
    func fetcher() -> AnyPublisher<Model, Error> {
        asyncToPublisher(fetch)
    }
}

private func asyncToPublisher<T>(_ function: @escaping () async throws -> T) -> AnyPublisher<T, Error> {
    Deferred {
        Future { promise in
            Task {
                do {
                    let result = try await function()
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
    .eraseToAnyPublisher()
}
