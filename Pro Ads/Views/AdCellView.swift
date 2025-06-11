//
//  AdCellView.swift
//  Pro Ads
//
//  Created by Sourav on 11/06/25.
//

import SwiftUI

struct AdCellView: View {
    let cellData: Ad
    @ObservedObject var favoriteManager: FavoriteManager
    
    var body: some View {
        VStack (spacing: 10) {
            ZStack (alignment: .topTrailing){
                AsyncImage(url: cellData.fullImageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Image(systemName: "photo.artframe")
                            .foregroundColor(.red)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .clipped()
                                
                Button(action: {
                    favoriteManager.toggleFavorite(ad: cellData)
                }) {
                    Image(systemName: favoriteManager.isFavorited(adID: cellData.id) ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
            }
            
            VStack (alignment: .leading, spacing: 10){
                Text(cellData.description ?? "Unknown Description")
                    .font(.title3)
                    .lineLimit(2)
                Text("Price: \(cellData.price?.total ?? 00) NOK")
                    .font(.subheadline)
                Text("Location: \(cellData.location ?? "Unknown location")")
                    .font(.footnote)
            }
            .padding()
            
        }
        .background(Color.white.opacity(0.8))
        .cornerRadius(20)
        .shadow(color: Color(#colorLiteral(red: 0.5755557418, green: 0.7498796582, blue: 1, alpha: 0.5568087748)), radius: 5, x: 5, y: 5)
    
    }
}

#Preview {
    AdCellView(cellData: Ad(description: "", id: "1234", url: "", adType: "Test", location: "", type: "", price: nil, image: nil, score: nil), favoriteManager: FavoriteManager())
}
