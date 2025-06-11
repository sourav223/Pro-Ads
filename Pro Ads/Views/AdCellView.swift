//
//  AdCellView.swift
//  Pro Ads
//
//  Created by Sourav on 11/06/25.
//

import SwiftUI

struct AdCellView: View {
    var body: some View {
        VStack (spacing: 10) {
            ZStack (alignment: .topTrailing){
                Image(systemName: "photo.artframe")
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                Button(action: {
                    
                }) {
                    Image(systemName: "heart.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
            }
            
            Text("Description")
                .font(.title)
            Text("Price 100.00 NOK")
                .font(.subheadline)
            Text("Location: Oslo")
                .font(.footnote)
        }
        .padding()
        .background(Color.yellow.opacity(0.8))
        .cornerRadius(20)
        .shadow(color: Color(#colorLiteral(red: 0.5755557418, green: 0.7498796582, blue: 1, alpha: 0.5568087748)), radius: 5, x: 5, y: 5)
    
    }
}

#Preview {
    AdCellView()
}
