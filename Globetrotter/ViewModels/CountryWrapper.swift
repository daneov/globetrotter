//
//  CountryWrapper.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 10/10/2024.
//

import Foundation

struct CountryMetadata: Equatable, Hashable, Identifiable {
    var id: String {
        return field
    }

    let field: String
    let value: String
}

// Used to abstract the model away from the View
struct CountryWrapper: Identifiable, Hashable {
    let id: String
    let name: String
    let flag: String

    let flagURL: URL?
    let metadata: [CountryMetadata]

    init(id: String, name: String, flag: String, flagURL: URL?, metadata: [CountryMetadata]) {
        self.id = id
        self.name = name
        self.flag = flag
        self.flagURL = flagURL
        self.metadata = metadata
    }
}

extension CountryWrapper {
    init(country: Country) {
        let currencies = country.currencies?.reduce("") { partial, entry in
            let shortCode = entry.key
            let details = entry.value
            let newEntry = String(format: "%@: %@ (%@)", shortCode, details.name, details.symbol)

            if partial.isEmpty {
                return newEntry
            }
            return String(format: "%@\n%@", partial, newEntry)
        }

        let capitals = country.capital?.reduce("") { partial, entry in
            if partial.isEmpty {
                return entry
            }
            return String(format: "%@\n%@", partial, entry)
        }

        let area = String(format: "%@ square meters", country.area.formatted(.number))
        let metadata = [
            CountryMetadata(field: "Currencies", value: currencies ?? "None"),
            CountryMetadata(field: "Capital(s)", value: capitals ?? "None"),
            CountryMetadata(field: "Area", value: area),
        ]
        let flagURL = country.flags["png"].flatMap { URL(string: $0) }

        self = .init(
            id: country.cca2,
            name: country.name.commonName,
            flag: country.flag,
            flagURL: flagURL,
            metadata: metadata
        )
    }
}
