//
//  EndpointTests.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 10/10/2024.
//

@testable import Globetrotter
import Testing

struct EndpointTests {
    @Test func countryEndpointPointsToTheCorrectPath() {
        #expect(Endpoint.countries.url.lastPathComponent == "all")
    }
}
