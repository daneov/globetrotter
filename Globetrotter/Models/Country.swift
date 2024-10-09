//
//  Country.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 09/10/2024.
//

import Foundation

struct Country: Decodable, Equatable {
    let name: CountryName
}

extension Country {
    struct CountryName: Decodable, Equatable {
        let commonName: String

        private enum CodingKeys: String, CodingKey {
            case commonName = "common"
        }
    }
}
