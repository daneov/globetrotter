//
//  Country+Fixtures.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 09/10/2024.
//

import Foundation
@testable import Globetrotter

extension Globetrotter.Country {
    static func fixture(
        name: String = "",
        identifier: String = "",
    ) -> Self {
        return .init(
            name: .init(commonName: name),
            cca2: identifier
        )
    }
}

private enum LoadError: Error {
    case NoSuchFile(filename: String)
}

extension Country {
    static func jsonFixture<T: Decodable>() throws -> [T] {
        let filename = "\(T.self)".lowercased()
        guard let url = Bundle.current.url(forResource: filename, withExtension: "json") else {
            throw LoadError.NoSuchFile(filename: filename)
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let jsonData = try decoder.decode([T].self, from: data)

        return jsonData
    }
}

extension Bundle {
    static var current: Bundle {
        class __ {}
        return Bundle(for: __.self)
    }
}
