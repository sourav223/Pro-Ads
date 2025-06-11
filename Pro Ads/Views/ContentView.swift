//
//  ContentView.swift
//  Pro Ads
//
//  Created by Sourav on 11/06/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = AdListViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                Color.white
                    .ignoresSafeArea(.all)
                VStack {
                    Picker("Filter", selection: $viewModel.showAllFavourites) {
                        Text("All Ads").tag(false)
                        Text("Favorites Only").tag(true)
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    Spacer()

                    if viewModel.isLoading {
                        ProgressView("Loading Ads...")
                    } else if let errorMessage = viewModel.errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                        Button("Retry") {
                            viewModel.fetchAds()
                        }
                    } else {
                        LazyVGrid(columns: [GridItem()]) {
                            ForEach(viewModel.filteredAds) { ad in
                                AdCellView(
                                    cellData: ad,
                                    favoriteManager: viewModel.favoriteManager
                                )
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("List Ads")
                .onAppear {
                    viewModel.fetchAds()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
