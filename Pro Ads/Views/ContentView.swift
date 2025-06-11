//
//  ContentView.swift
//  Pro Ads
//
//  Created by Sourav on 11/06/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.red
                    .ignoresSafeArea(.all)
                List {
                    ForEach(0..<20, id: \.self) { _ in
                        AdCellView()
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .listRowSeparator(.hidden)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
