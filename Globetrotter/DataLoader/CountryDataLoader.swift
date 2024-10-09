//
//  DataLoader.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 09/10/2024.
//
import Foundation

struct CountryDataLoader: DataLoader {
    var httpClient: HTTPClient
    var source: URL {
        return Endpoint.countries.url
    }

    typealias Model = [Country]
}
