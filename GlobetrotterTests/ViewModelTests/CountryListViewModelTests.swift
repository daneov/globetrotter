//
//  CountryListViewModelTests.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 09/10/2024.
//

import Combine
import Foundation
import Testing

@testable import Globetrotter

struct CountryListViewModelTests {
    var cancellables = Set<AnyCancellable>()

    @Test func doesNotCallOnCreation() {
        let dataLoader = MockDataLoader(response: .success(value: []))
        _ = CountryListViewModel(dataLoader: dataLoader)

        #expect(dataLoader.receivedCalls == 0)
    }

    @Test mutating func retrievesAndSortsCountries() async throws {
        let stubbedValue = [Country.fixture(name: "Sweden"), Country.fixture(name: "Afghanistan")]
        let dataLoader = MockDataLoader(response: .success(value: stubbedValue))

        let viewModel = CountryListViewModel(dataLoader: dataLoader)
        viewModel.loadCountries()

        let expected = stubbedValue.map(CountryWrapper.init).sorted(by: {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        })
        let result = try await waitForPublishedValue(viewModel.$countries, expectedValue: expected, timeout: .seconds(1))
        #expect(result == expected)
    }
}

class MockDataLoader: DataLoader {
    typealias Model = [Country]

    enum Response {
        case success(value: Model)
        case failure(err: Error)
    }

    var source: URL {
        return try! #require(URL(string: "https://some.url"))
    }

    var httpClient: any Globetrotter.HTTPClient
    var response: Response
    var receivedCalls = UInt(0)

    init(response: Response) {
        struct UnexpectedInvocation: Error {}

        httpClient = MockHTTPClient(response: .failure(err: UnexpectedInvocation()))
        self.response = response
    }

    func fetch() async throws -> [Globetrotter.Country] {
        receivedCalls += 1

        switch response {
        case let .success(value): return value
        case let .failure(err): throw err
        }
    }
}

private func waitForPublishedValue<T: Equatable>(
    _ publisher: Published<T>.Publisher,
    expectedValue: T,
    timeout: DispatchTimeInterval
) async throws -> T {
    var cancellables = Set<AnyCancellable>()

    return try await withCheckedThrowingContinuation { continuation in
        publisher
            .sink { value in
                if value == expectedValue {
                    continuation.resume(returning: value)
                }
            }
            .store(in: &cancellables)

        // If timeout is reached before receiving the expected value
        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            continuation.resume(throwing: NSError(domain: "Timeout", code: 0, userInfo: nil))
        }
    }
}
