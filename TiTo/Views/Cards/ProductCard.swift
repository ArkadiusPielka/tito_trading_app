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
        return produkt.userId != userAuthViewModel.user?.id
    }
    
    let produkt: FireProdukt
    
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
                        AsyncImage(url: URL(string: produkt.imageURL ?? "")) { image in
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
                            Text(produkt.advertismentType)
                            Spacer()
                            Text(formattedDate)
                        }
                        .foregroundStyle(Color("subText"))
                        .font(.footnote)
                        .font(.title3)
                    }
                    
                    Text(produkt.title)
                        .font(.title2)
                        .lineLimit(1)
                    
                    HStack {
                        Text("\(produkt.price) €")
                        Text(produkt.priceType)
                            .bold()
                        Spacer()
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
            }
            
        }
        .frame(width: .infinity, height: CGFloat.cardHeight, alignment: .top)
        .padding(0)
        .background(Color("cardBack"))
        .cornerRadius(CGFloat.cardCornerRadius)
        .shadow(color: Color("subText"), radius: 4, x: -2, y: 4)
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        
        let currentDate = Date()
        
        if Calendar.current.isDateInToday(produkt.startAdvertisment) {
            dateFormatter.locale = Locale(identifier: "de_DE")
            dateFormatter.dateFormat = "E, HH:mm"
        } else {
            dateFormatter.dateStyle = .short
        }
        
        return dateFormatter.string(from: produkt.startAdvertisment)
    }
    
    func isLike() {
        
    }
}

#Preview{
    ProductCard(
        produkt: FireProdukt(
            userId: "1", title: "Einkaufstascheasdasdad", category: "", condition: "VB", shipment: "",
            description: "", advertismentType: "Ich biete", price: "20", priceType: "VB",
            startAdvertisment: Date.now,
            imageURL:
                "https://firebasestorage.googleapis.com:443/v0/b/tito-91e64.appspot.com/o/images%2F073479CD-7A2D-4FFA-A860-0D1076C4303A.jpeg?alt=media&token=2da52bd1-8e81-4b23-8e58-bfa8add10800"
        ))
    .environmentObject(UserAuthViewModel())
}
