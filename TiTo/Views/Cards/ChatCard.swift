//
//  ChatCard.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.02.24.
//

import SwiftUI

struct ChatCard: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    
    var product: FireProdukt
    
    var body: some View {
        NavigationStack {
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
                        HStack {
                            Text(userAuthViewModel.productUser?.name ?? "Akki")
                                .font(.title2)
                            
                            Spacer()
                            Text("\(product.price) €")
                                .bold()
                                .foregroundColor(Color("message"))
                            
                            Text(product.priceType)
                                .bold()
                                .foregroundColor(Color("message"))
                            
                            
                        }
                    }
                    
                    Text(product.title)
                        .font(.title2)
                        .lineLimit(1)
                    
                    
                    Text(chatViewModel.messages.last?.text ?? "hallo")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .italic()
                        .lineLimit(1)
                }
                
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
            }
            .frame(width: .infinity, height: CGFloat.cardHeight, alignment: .top)
            .background(Color("cardBack"))
            .cornerRadius(CGFloat.cardCornerRadius)
            .shadow(color: Color("message"), radius: 4, x: -2, y: 4)
            .background(
    //                    NavigationLink("", destination: ProductEditView(product: product), isActive: $isEditing)
                        )
        }
       
        .onAppear{
            userAuthViewModel.fetchProductUser(with: product.userId)
        }
        .padding()
    }
    
}

//#Preview {
//    ChatCard(product: FireProdukt(
//        userId: "1", title: "Einkaufstascheasdasdad", category: "", condition: "VB", shipment: "",
//        description: "", advertismentType: "Ich biete", price: "20", priceType: "VB",
//        startAdvertisment: Date.now,
//        imageURL:
//            "https://arkadiuspielka.files.wordpress.com/2024/02/71qmz4m-yjl.jpg"
//    ))
//        .environmentObject(UserAuthViewModel())
//        .environmentObject(ProductViewModel())
//        .environmentObject(ChatViewModel())
//}
