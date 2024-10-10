//
//  CompositionRoot.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 10/10/2024.
//
import Foundation

enum CompositionRoot {
    static var countryDetailViewModel: (_ country: CountryWrapper) -> CountryDetailViewModel {
        return { (country: CountryWrapper) in
            CountryDetailViewModel(country: country)
        }
    }

    static var countryListViewModel: CountryListViewModel {
        CountryListViewModel(dataLoader: countryDataLoader)
    }

    static var countryDataLoader: CountryDataLoader {
        CountryDataLoader(httpClient: httpClient)
    }

    static var httpClient: HTTPClient {
        return URLSession.shared
    }
}
