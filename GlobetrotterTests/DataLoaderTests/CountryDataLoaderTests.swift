//
//  CountryDataLoaderTests.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 09/10/2024.
//

import Foundation
import Testing
import XCTest

@testable import Globetrotter

struct CountryDataLoaderTests {
    @Test func correctlyParsesAnEmptyList() async throws {
        let mockClient = MockHTTPClient(response: .success(data: Data("[]".utf8)))
        let countryLoader = CountryDataLoader(httpClient: mockClient)

        let result = try await countryLoader.fetch()
        #expect(result.count == 0)
    }

    @Test func contactsTheProperEndpoint() async throws {
        let mockClient = MockHTTPClient(response: .success(data: Data("[]".utf8)))
        let countryLoader = CountryDataLoader(httpClient: mockClient)

        _ = try? await countryLoader.fetch()
        #expect(mockClient.contactedURLs.contains(where: { $0 == Endpoint.countries.url }))
    }

    @Test func throwsAnErrorOnNon200() async throws {
        let mockClient = MockHTTPClient(response: .failure(err: URLError(.badURL)))
        let countryLoader = CountryDataLoader(httpClient: mockClient)

        await #expect(throws: URLError.self, performing: { try await countryLoader.fetch() })
    }
}

class MockHTTPClient: HTTPClient {
    enum Response {
        case success(data: Data?)
        case failure(err: Error)
    }

    let response: Response
    var contactedURLs: [URL?] = []

    init(response: Response, contactedURLs: [URL?] = []) {
        self.response = response
        self.contactedURLs = contactedURLs
    }

    func request(_ request: URLRequest) async throws -> (Data?, HTTPURLResponse) {
        contactedURLs.append(request.url)
        switch response {
        case let .success(data):
            let response = try HTTPURLResponse(url: XCTUnwrap(request.url), statusCode: 200, httpVersion: "", headerFields: nil)
            return try (data, XCTUnwrap(response))
        case let .failure(err):
            throw err
        }
    }
}
