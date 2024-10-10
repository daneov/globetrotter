//
//  Country.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 09/10/2024.
//

import Foundation

// We could also go for a custom decoder and parse it by-property to tailor it and
// get the types immediately right. Chosing not to because of time constraints.
struct Country: Decodable, Equatable {
    let name: CountryName
    let capital: [String]?
    let population: UInt
    let area: Double
    let cca2: String
    let flag: String
    let flags: [String: String]

    let currencies: [String: Currency]?
}

extension Country {
    struct CountryName: Decodable, Equatable {
        let commonName: String

        private enum CodingKeys: String, CodingKey {
            case commonName = "common"
        }
    }

    struct Currency: Decodable, Equatable {
        let name: String
        let symbol: String
    }
}
