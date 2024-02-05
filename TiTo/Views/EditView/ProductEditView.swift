//
//  ProductEditView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 05.02.24.
//

import SwiftUI

struct ProductEditView: View {
    
    @EnvironmentObject var productViewModel: ProductViewModel
    
    var product: FireProdukt
    
    @State var title = ""
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.imageURL ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipped()
                
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .font(.callout)
            }
            CustomAddField(hint: "Titel", text: $title, strokeColor: Color("advertisment"))
        }
        .frame(maxWidth: CGFloat.maxScreenWidth, maxHeight: 300)
        .padding(.vertical, 16)
        .onAppear{
            title = productViewModel.title 
        }
    }
}

#Preview {
    ProductEditView(
        product: FireProdukt(
            userId: "1", title: "Einkaufstascheasdasdad", category: "", condition: "VB", shipment: "",
            description: "", advertismentType: "Ich biete", price: "20", priceType: "VB",
            startAdvertisment: Date.now,
            imageURL:
                "https://arkadiuspielka.files.wordpress.com/2024/02/71qmz4m-yjl.jpg"
        ))
    .environmentObject(ProductViewModel())
}
