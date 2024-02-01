//
//  ProductCardWithSwipe.swift
//  TiTo
//
//  Created by Arkadius Pielka on 30.01.24.
//

import SwiftUI

struct ProductCardWithSwipe: View {
    
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var produktViewModel: ProductViewModel
    
    let product: FireProdukt
    
    var body: some View {
        SwipeActionView(actions: [
            Action(color: .blue, name: "Edit", systemIcon: "pencil", action: { print("edit") }),
            Action(color: .red, name: "Delete", systemIcon: "trash.fill", action: { delete() })
           
        ]) {
            ProductCard(product: product)
        }
        .frame(width: .infinity, height: CGFloat.cardHeight, alignment: .top)
        .background(Color("cardBack"))
        .cornerRadius(CGFloat.cardCornerRadius)
        .shadow(color: Color("subText"), radius: 4, x: -2, y: 4)
//        .environmentObject(userAuthViewModel)
    }
    
    func delete() {
        produktViewModel.deleteAdvertisment(with: product.id!)
        print("delete")
    }
}

#Preview {
    ProductCardWithSwipe(
        product: FireProdukt(
            userId: "1", title: "Einkaufstascheasdasdad", category: "", condition: "VB", shipment: "",
            description: "", advertismentType: "Ich biete", price: "20", priceType: "VB",
            startAdvertisment: Date.now,
            imageURL: "https://firebasestorage.googleapis.com:443/v0/b/tito-91e64.appspot.com/o/images%2F073479CD-7A2D-4FFA-A860-0D1076C4303A.jpeg?alt=media&token=2da52bd1-8e81-4b23-8e58-bfa8add10800"
        ))
    .environmentObject(UserAuthViewModel())
    .environmentObject(ProductViewModel())
}



