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
            imageURL: "https://arkadiuspielka.files.wordpress.com/2024/02/71qmz4m-yjl.jpg"
        ))
    .environmentObject(UserAuthViewModel())
    .environmentObject(ProductViewModel())
}



