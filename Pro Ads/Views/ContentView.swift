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
            ZStack {
                Color.red
                    .ignoresSafeArea(.all)
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
                    List {
                        ForEach(viewModel.ads) { ad in
                            AdCellView(cellData: ad)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .listRowSeparator(.hidden)
                }
            }
            .onAppear{
                viewModel.fetchAds()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
