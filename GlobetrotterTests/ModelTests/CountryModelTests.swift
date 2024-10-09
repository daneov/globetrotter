//
//  CountryModelTests.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 09/10/2024.
//

import Testing

import Foundation
@testable import Globetrotter

struct CountryModelTests {
    @Test("CountryModelSerialization")
    func serializationTest() async throws {
        let countries: [Country] = try Country.jsonFixture()
        #expect(countries.count == 1)
    }

    @Test("TestCountryNameSerialization")
    func confirmCountryNameProperties() async throws {
        let countries: [Country] = try Country.jsonFixture()
        #expect(countries.first?.name.commonName == "South Georgia")
    }
}
