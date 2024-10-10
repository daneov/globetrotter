//
//  CountryListViewModel.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 09/10/2024.
//

import Combine
import SwiftUI

/*
 We currently load the information when the app starts, but don't account for the
 lack of connectivity. The user is able to pull down and refresh.

 This can be done by using NWPathMonitor.
 */
final class CountryListViewModel: ObservableObject {
    @Published var state: FetchingState = .loading
    @Published var countries: [CountryWrapper] = []

    private let countryFetcher: AnyPublisher<[Country], any Error>
    private var cancellable: AnyCancellable?

    init<T: DataLoader>(dataLoader: T) where T.Model == [Country] {
        countryFetcher = dataLoader.fetcher()
    }

    // Load countries, and cancels the previous request by releasing the cancellable
    // of that request.
    func loadCountries() {
        cancellable = countryFetcher
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.state = .loading
            })
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case let .failure(err):
                    self?.state = .error(err: err)
                case .finished:
                    self?.state = .completed
                }
            }, receiveValue: { [weak self] countries in
                let sortedCountries = countries
                    .map(CountryWrapper.init)
                    .sorted { c1, c2 in
                        c1.name.localizedCaseInsensitiveCompare(c2.name) == .orderedAscending
                    }
                self?.countries = sortedCountries
            })
    }

    enum FetchingState {
        case loading
        case completed
        case error(err: any Error)
    }
}
