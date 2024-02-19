//
//  ProductCardWithSwipe.swift
//  TiTo
//
//  Created by Arkadius Pielka on 30.01.24.
//

import SwiftUI

struct ProductCardWithSwipe: View {
    
    @EnvironmentObject var messagesViewModel: MessagesViewModel
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var produktViewModel: ProductViewModel
    
    @State private var isEditing = false
    @State private var showAlert = false
    
    let product: FireProduct
    
    var body: some View {
        NavigationStack {
            SwipeActionView(actions: [
                Action(color: .blue, name: "Edit", systemIcon: "pencil", action: { 
                    
                    isEditing = true
                }),
                Action(color: .red, name: "Delete", systemIcon: "trash.fill", action: { delete() })
                
            ]) {
                ProductCard(product: product)
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .frame(height: CGFloat.cardHeight)
        .background(Color("cardBack"))
        .cornerRadius(CGFloat.cardCornerRadius)
        .shadow(color: Color("subText"), radius: 4, x: -2, y: 4)
        .background(
                    NavigationLink("", destination: ProductEditView(product: product), isActive: $isEditing)
                    )
    }

    func delete() {
        produktViewModel.deleteAdvertisment(with: product.id!)
        messagesViewModel.deleteMessages(with: product.id!)
    }
}

#Preview {
    ProductCardWithSwipe(
        product: FireProduct(
            userId: "1", title: "Einkaufstasche", category: "", condition: "VB", shipment: "",
            description: "", advertismentType: "Ich biete", price: "20", priceType: "VB",
            startAdvertisment: Date.now,
            imageURL: "https://arkadiuspielka.files.wordpress.com/2024/02/71qmz4m-yjl.jpg"
        ))
    .environmentObject(UserAuthViewModel())
    .environmentObject(ProductViewModel())
    .environmentObject(MessagesViewModel())
}



