//
//  CountryDetailViewModel.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 10/10/2024.
//

import Combine

final class CountryDetailViewModel: ObservableObject {
    let country: CountryWrapper

    init(country: CountryWrapper) {
        self.country = country
    }
}
