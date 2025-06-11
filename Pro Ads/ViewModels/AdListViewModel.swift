//
//  AdListViewModel.swift
//  Pro Ads
//
//  Created by Sourav on 11/06/25.
//

import Foundation
import Combine
import SwiftUICore

class AdListViewModel: ObservableObject {
    @Published var ads: [Ad] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showAllFavourites: Bool = false

    private let apiHandler: APIHandeler
    private var cancellables = Set<AnyCancellable>()
    @ObservedObject var favoriteManager: FavoriteManager
    
    var filteredAds: [Ad] {
            if showAllFavourites {
                return ads.filter { favoriteManager.favoriteAds[$0.id] != nil }
            } else {
                return ads
            }
        }
    
    init(apiHandler: APIHandeler = APIHandeler(), favoriteManager: FavoriteManager = FavoriteManager()) {
        self.apiHandler = apiHandler
        self.favoriteManager = favoriteManager
        favoriteManager.$favoriteAds
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }

    func fetchAds() {
        isLoading = true
        errorMessage = nil
        apiHandler.fetchAds()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] fetchedAds in
                self?.ads = fetchedAds
            })
            .store(
                in: &cancellables
            )
    }
}
