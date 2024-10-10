//
//  CountryListView.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 09/10/2024.
//

import SwiftUI

struct CountryListView: View {
    @StateObject var viewModel: CountryListViewModel

    var body: some View {
        VStack(alignment: .leading) {
            List {
                switch viewModel.state {
                case .loading:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .completed:
                    ForEach(viewModel.countries) { country in
                        Text(country.name)
                    }
                case let .error(err):
                    Text("Whoops, an error occured!. Error: \(err)")
                }
            }
            .listStyle(.plain)
            .refreshable {
                viewModel.state = .loading
                viewModel.loadCountries()
            }
        }
        .navigationTitle("Countries")
        .onAppear {
            if viewModel.countries.isEmpty {
                viewModel.loadCountries()
            }
        }
    }
}

#Preview {
    CountryListView(viewModel: CompositionRoot.countryListViewModel)
}
