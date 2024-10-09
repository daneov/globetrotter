//
//  HTTPClient.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 09/10/2024.
//

import Foundation
import Network

protocol HTTPClient {
    func request(_ request: URLRequest) async throws -> (Data?, HTTPURLResponse)
}

extension URLSession: HTTPClient {
    struct InvalidURLResponse: Error {}

    func request(_ request: URLRequest) async throws -> (Data?, HTTPURLResponse) {
        let (data, response) = try await self.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLSession.InvalidURLResponse()
        }

        return (data, httpResponse)
    }
}
