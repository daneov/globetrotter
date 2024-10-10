//
//  GlobetrotterApp.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 09/10/2024.
//

import SwiftUI

@main
struct GlobetrotterApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CountryListView(viewModel: CompositionRoot.countryListViewModel)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case let .detail(country):
                            CountryDetailView(viewModel: CompositionRoot.countryDetailViewModel(country))
                        }
                    }
            }
        }
    }
}
