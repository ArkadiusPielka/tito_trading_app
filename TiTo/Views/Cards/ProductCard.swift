//
//  ProductCard.swift
//  TiTo
//
//  Created by Arkadius Pielka on 16.01.24.
//

import SwiftUI

struct ProductCard: View {
    
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    
    var showLikeBtn: Bool {
        return product.userId != userAuthViewModel.user?.id
    }
    
    let product: FireProdukt
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    if showLikeBtn {
                        LikeBtn(action: isLike)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }
            HStack(alignment: .top, spacing: 0) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: CGFloat.cardWidth, height: CGFloat.cardHeight)
                    .background(
                        AsyncImage(url: URL(string: product.imageURL ?? "")) { image in
                            image
                                .resizable()
                                .frame(width: CGFloat.cardWidth, height: CGFloat.cardHeight)
                                .scaledToFit()
                                .clipped()
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .font(.callout)
                                .frame(width: CGFloat.cardWidth, height: CGFloat.cardHeight)
                        }
                    )
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Group {
                            Text(product.advertismentType)
                            Spacer()
                            Text(formattedDate)
                        }
                        .foregroundStyle(Color("subText"))
                        .font(.footnote)
                        .font(.title3)
                    }
                    
                    Text(product.title)
                        .font(.title2)
                        .lineLimit(1)
                    
                    HStack {
                        Text("\(product.price) €")
                        Text(product.priceType)
                            .bold()
                        Spacer()
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
            }
            
            
        }
        
//        .frame(width: .infinity, height: CGFloat.cardHeight, alignment: .top)
//        .background(Color("cardBack"))
//        .cornerRadius(CGFloat.cardCornerRadius)
//        .shadow(color: Color("subText"), radius: 4, x: -2, y: 4)
       
    }
    
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        
        let currentDate = Date()
        
        if Calendar.current.isDateInToday(product.startAdvertisment) {
            dateFormatter.locale = Locale(identifier: "de_DE")
            dateFormatter.dateFormat = "E, HH:mm"
        } else {
            dateFormatter.dateStyle = .short
        }
        
        return dateFormatter.string(from: product.startAdvertisment)
    }
    
    func isLike() {
        //TODO: func
    }
}

#Preview{
    ProductCard(
        product: FireProdukt(
            userId: "1", title: "Einkaufstascheasdasdad", category: "", condition: "VB", shipment: "",
            description: "", advertismentType: "Ich biete", price: "20", priceType: "VB",
            startAdvertisment: Date.now,
            imageURL:
                "https://arkadiuspielka.files.wordpress.com/2024/02/71qmz4m-yjl.jpg"
        ))
    .environmentObject(UserAuthViewModel())
}
