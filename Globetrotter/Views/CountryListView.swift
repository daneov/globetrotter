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
                    ForEach(viewModel.displayedCountries) { country in
                        NavigationLink(value: Route.detail(country)) {
                            Text(country.name)
                        }
                    }
                case let .error(err):
                    VStack(alignment: .center) {
                        Spacer()
                        Text("Whoops, an error occured!. Error: \(err)")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom, 5)
                        Button {
                            viewModel.loadCountries()
                        } label: {
                            HStack {
                                Image(systemName: "arrow.clockwise.circle")
                                Text("Try again").padding(.top, 5)
                            }
                        }.foregroundStyle(.blue)
                        Spacer()
                    }
                }
            }
            .listStyle(.plain)
            .refreshable {
                viewModel.state = .loading
                viewModel.loadCountries()
            }
            .searchable(text: $viewModel.searchText)
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
