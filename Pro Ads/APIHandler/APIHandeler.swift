//
//  APIHandeler.swift
//  Pro Ads
//
//  Created by Sourav on 11/06/25.
//

import Foundation
import Combine

class APIHandeler {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchAds() -> AnyPublisher<[Ad], NetworkError> {
        guard let url = URL(string: "https://gist.githubusercontent.com/baldermork/6a1bcc8f429dcdb8f9196e917e5138bd/raw/discover.json") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: url)
            .mapError { NetworkError.network($0) }
            .flatMap { data, response -> AnyPublisher<[Ad], NetworkError> in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    return Fail(error: NetworkError.network(URLError(.badServerResponse))).eraseToAnyPublisher()
                }
                return Just(data)
                    .decode(type: Response.self, decoder: JSONDecoder())
                    .map { $0.items }
                    .mapError { NetworkError.decoding($0) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case network(Error)
    case decoding(Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "The URL provided was invalid."
        case .network(let error): return "Network request failed: \(error.localizedDescription)"
        case .decoding(let error): return "Failed to decode the response: \(error.localizedDescription)"
        case .unknown: return "An unknown error occurred."
        }
    }
}
