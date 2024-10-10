//
//  CountryDetailViewModelTests.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 10/10/2024.
//

@testable import Globetrotter
import Testing

struct CountryDetailViewModelTests {
    @Test func assignsPropertyCorrectly() {
        let country = CountryWrapper(country: Country.fixture())
        let viewModel = CountryDetailViewModel(country: country)

        #expect(viewModel.country == country)
    }
}
