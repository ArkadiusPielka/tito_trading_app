//
//  ProductDetailView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 01.02.24.
//

import SwiftUI

struct ProductDetailView: View {
    
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    
    var product: FireProdukt
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                AsyncImage(url: URL(string: product.imageURL ?? "")) { image in
                    image
                        .resizable()
                        .frame(width: 80, height: 80)
                        .scaledToFit()
                        .clipped()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .font(.callout)
                        .frame(width: 60, height: 60)
                }
                .cornerRadius(CGFloat.cardCornerRadius)
                VStack(alignment: .leading) {
                    Text(product.title)
                    HStack {
                        Text("\(product.price) €")
                        Text(product.priceType)
                    }
                }
            }
        }
    }
}

#Preview {
    ProductDetailView(product: FireProdukt(
        userId: "1", title: "Einkaufstascheasdasdad", category: "", condition: "VB", shipment: "",
        description: "", advertismentType: "Ich biete", price: "20", priceType: "VB",
        startAdvertisment: Date.now,
        imageURL:
            "https://firebasestorage.googleapis.com:443/v0/b/tito-91e64.appspot.com/o/1jPo8dAjiCXwyWfWDLcuAo6uRWH3%2FproductImages%2FQn1tA9vRR6ETOhyOYB58.jpg?alt=media&token=2808da4e-d62d-4d12-875a-a6ba43a1b813"
    ))
        .environmentObject(UserAuthViewModel())
        .environmentObject(ProductViewModel())
}
