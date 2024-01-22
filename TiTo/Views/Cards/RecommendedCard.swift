//
//  RecommendedCard.swift
//  TiTo
//
//  Created by Arkadius Pielka on 10.01.24.
//

import SwiftUI

struct RecommendedCard: View {
    
    let produkt: Recommended
    
    var body: some View {
        
            HStack(spacing: 12) {
              
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: CGFloat.cardWidth, height: CGFloat.cardHeight)
                        .background(
                            AsyncImage(url: produkt.img1) { image in
                                image
                                    .resizable()
                                    .frame(width: CGFloat.cardWidth, height: CGFloat.cardHeight)
                                    .scaledToFit()
                                    .clipped()
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: CGFloat.cardWidth, height: CGFloat.cardHeight)
                            }
                        )
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(produkt.title)
                            .font(.title2)
                        
                        Text(produkt.descript)
                            .foregroundStyle(Color("subText"))
                            .font(.footnote)
                            .lineLimit(1)
                        Text("\(produkt.price) €")
                    }
                Spacer()
            }
            .frame(width: CGFloat.recomendedWidth, height: CGFloat.cardHeight, alignment: .leading)
            .background(Color("cardBack"))
            .cornerRadius(CGFloat.cardCornerRadius)
            .shadow(color: Color("subText"), radius: 4, x: -2, y: 4)
        }
    }

#Preview {
    RecommendedCard(produkt: Recommended(id: 1, img1: URL(string:  "https://firebasestorage.googleapis.com:443/v0/b/tito-91e64.appspot.com/o/images%2F073479CD-7A2D-4FFA-A860-0D1076C4303A.jpeg?alt=media&token=2da52bd1-8e81-4b23-8e58-bfa8add10800"), price: "9.95", title: "Tasche", category: "Box", descript: "Eine Einkaufstasche"))
}
