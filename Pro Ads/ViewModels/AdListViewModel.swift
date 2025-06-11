//
//  AdListViewModel.swift
//  Pro Ads
//
//  Created by Sourav on 11/06/25.
//

import Foundation
import SwiftUI
import Combine

class AdListViewModel: ObservableObject {
    @Published var ads: [Ad] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let apiHandler: APIHandeler
    private var cancellables = Set<AnyCancellable>()
    
    init(apiHandler: APIHandeler = APIHandeler()) {
        self.apiHandler = apiHandler
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
