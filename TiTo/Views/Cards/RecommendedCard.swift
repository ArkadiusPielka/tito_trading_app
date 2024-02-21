//
//  RecommendedCard.swift
//  TiTo
//
//  Created by Arkadius Pielka on 10.01.24.
//

import SwiftUI

struct RecommendedCard: View {
    
    let product: Recommended
    
    var body: some View {
        
            HStack(spacing: 12) {
              
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: CGFloat.cardWidth, height: CGFloat.cardHeight)
                        .background(
                            AsyncImage(url: product.image) { image in
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
                        Text(product.title)
                            .font(.title2)
                        
                        Text(product.description)
                            .foregroundStyle(Color("subText"))
                            .font(.footnote)
                            .lineLimit(1)
                        Text("\(product.price) €")
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
    RecommendedCard(product: Recommended(id: 1, image: URL(string:  "https://arkadiuspielka.files.wordpress.com/2024/02/71qmz4m-yjl.jpg"), price: "9.95", title: "Tasche", category: "Box", description: "Eine Einkaufstasche"))
}
