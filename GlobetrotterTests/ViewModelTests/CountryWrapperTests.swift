//
//  CountryWrapperTests.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 10/10/2024.
//

import Foundation
import Testing

@testable import Globetrotter

struct CountryWrapperTests {
    @Test func initializationWithCountryObjectPopulatesFieldsCorrectly() throws {
        let remoteLocation = "https://some.url/image.png"
        let country = Country(
            name: .init(commonName: "Sweden"),
            capital: ["Stockholm"],
            population: 10_555_448,
            area: 450_295,
            cca2: "SE",
            flag: "🇸🇪",
            flags: ["png": remoteLocation],
            currencies: ["SEK": .init(name: "Swedish krona", symbol: "kr")]
        )
        let imageURL = URL(string: remoteLocation)
        try #require(imageURL != nil)

        let wrapper = CountryWrapper(country: country)
        #expect(wrapper.id == "SE")
        #expect(wrapper.name == "Sweden")
        #expect(wrapper.flag == "🇸🇪")
        #expect(wrapper.flagURL?.absoluteString == imageURL?.absoluteString)
    }
}
