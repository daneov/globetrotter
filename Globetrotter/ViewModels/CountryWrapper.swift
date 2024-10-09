//
//  CountryWrapper.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 10/10/2024.
//

import Foundation

// Used to abstract the model away from the View
struct CountryWrapper: Identifiable, Hashable {
    let id: String
    let name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

extension CountryWrapper {
    init(country: Country) {
        self = .init(
            id: country.cca2,
            name: country.name.commonName
        )
    }
}
