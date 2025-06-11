//
//  Response.swift
//  Pro Ads
//
//  Created by Sourav on 11/06/25.
//

import Foundation

// MARK: - Response

struct Response: Codable {
    let isPersonal: Bool?
    let hasConsent: Bool?
    let items: [Ad]
}

// MARK: - Ad
struct Ad: Codable, Identifiable {
    let description: String?
    let id: String
    let url: String?
    let adType: String
    let location: String?
    let type: String?
    let price: Price?
    let image: AdImage?
    let score: Double?
    
    enum CodingKeys: String, CodingKey {
        case description, id, url, location, type, price, image, score
        case adType = "ad-type"
    }
    
    var fullImageURL: URL? {
        guard let imageURLString = image?.url, let imageURL = URL(string: "https://images.finncdn.no/dynamic/480x360c/" + imageURLString) else {
            return nil
        }
        return imageURL
    }
}

// MARK: - Price
struct Price: Codable {
    let value: Int?
    let total: Int?
}

// MARK: - AdImage
struct AdImage: Codable {
    let url: String?
    let height: Int?
    let width: Int?
    let type: String?
    let scalable: Bool?
}
