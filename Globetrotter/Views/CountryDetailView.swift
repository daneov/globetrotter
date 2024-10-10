//
//  CountryDetailView.swift
//  Globetrotter
//
//  Created by Daneo Van Overloop on 10/10/2024.
//

import SwiftUI

struct CountryDetailView: View {
    @StateObject var viewModel: CountryDetailViewModel

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: viewModel.country.flagURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: 150)
            .border(.secondary)

            HStack(alignment: .top) {
                VStack {
                    ForEach(viewModel.country.metadata) { metadata in
                        HStack(alignment: .firstTextBaseline) {
                            Text(metadata.field)
                                .bold()
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Text(metadata.value)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                }
            }
        }
        .navigationTitle("\(viewModel.country.flag) \(viewModel.country.name)")
        .navigationBarTitleDisplayMode(.inline)
        Spacer()
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CountryDetailView(viewModel: CompositionRoot.countryDetailViewModel(
                CountryWrapper(
                    id: "",
                    name: "Sweden",
                    flag: "🇸🇪",
                    flagURL: URL(string: "https://flagcdn.com/w320/gs.png"),
                    metadata: [
                        CountryMetadata(field: "Currency", value: "AUD: Asutralian Dollar ($)"),
                    ]
                ))
            )
        }
    }
}
