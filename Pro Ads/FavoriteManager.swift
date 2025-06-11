//
//  FavoriteManager.swift
//  Pro Ads
//
//  Created by Sourav on 11/06/25.
//

import Foundation


class FavoriteManager: ObservableObject {
    private let favoritesKey = "favoritedAdIDs"
    @Published var favoriteAds: [String: Ad] {
        didSet {
            if let encoded = try? JSONEncoder().encode(
                Array(favoriteAds.values)
            ) {
                UserDefaults.standard.set(encoded, forKey: favoritesKey)
            } else {
                print("Error encoding favorited ads to Data.")
            }
        }
    }

    init() {
        if let savedAdsData = UserDefaults.standard.data(forKey: favoritesKey) {
            if let decodedAds = try? JSONDecoder().decode(
                [Ad].self,
                from: savedAdsData
            ) {
                self.favoriteAds = Dictionary(
                    uniqueKeysWithValues: decodedAds.map { ($0.id, $0)
                    })
            } else {
                print("Error decoding favorited ads from Data.")
                self.favoriteAds = [:]
            }
        } else {
            self.favoriteAds = [:]
        }
    }

    func isFavorited(adID: String) -> Bool {
        favoriteAds[adID] != nil
    }

    func toggleFavorite(ad: Ad) {
        if isFavorited(adID: ad.id) {
            favoriteAds.removeValue(forKey: ad.id)
        } else {
            favoriteAds[ad.id] = ad
        }
    }
}
