//
//  Endpoint.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 10/10/2024.
//
import Foundation

// We could build the functionality to filter out only those fields we need,
// nice improvement for the future.

enum Endpoint: String {
    case countries = "all"
}

extension Endpoint {
    var url: URL {
        return URL.url(for: self)
    }
}

private extension URL {
    static func url(for endpoint: Endpoint) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "restcountries.com"
        components.path = "/v3.1/\(endpoint.rawValue)"

        guard let url = components.url else {
            preconditionFailure("Wrong URL components: \(components)")
        }

        return url
    }
}
