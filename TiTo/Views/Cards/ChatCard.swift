//
//  ChatCard.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.02.24.
//

import SwiftUI

struct ChatCard: View {
    
    @EnvironmentObject var messagesViewModel: MessagesViewModel
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    
    var product: FireProduct
    
    var messages: [Message] {
        let unsortedMessages = messagesViewModel.productMessages.elements.first(where: { $0.key == product.id } )?.value ?? []
        return unsortedMessages.sorted { $0.createdAt < $1.createdAt }
    }
    
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
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        HStack {
                            
                            if let firstMessage = messages.first?.recipientId {
                                
                                if userAuthViewModel.user?.id == firstMessage {
                                    Text(userAuthViewModel.userSender?.name ?? "")
                                   
                                        .font(.title2)
                                        .onAppear{
                                            print("ich bin im if")
                                        }
                                } else {
                                    Text(userAuthViewModel.productUser?.name ?? "Akki")
                                   
                                        .font(.title2)
                                        .onAppear {
                                            print("ich bin im else")
                                        }
                                }
                            }
                            
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
                    
                    let lastMessage = messages.last
                    
                    Text(lastMessage?.text ?? "ja")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .italic()
                        .lineLimit(1)
                    
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
            }
            .background(Color("cardBack"))
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .frame(height: CGFloat.cardHeight)
        .cornerRadius(CGFloat.cardCornerRadius)
        .shadow(color: Color("message"), radius: 4, x: -2, y: 4)
        .onAppear{
            
            userAuthViewModel.fetchProductOwner(with: product.userId)
            if !messages.isEmpty {
                userAuthViewModel.fetchUserSender(with: messages.first?.senderId ?? "")
            }
        }
        .padding(.horizontal, 16)
    }
    
}

#Preview {
    ChatCard(product: FireProduct(
        userId: "1", title: "Einkaufstascheasdasdad", category: "", condition: "VB", shipment: "",
        description: "", advertismentType: "Ich biete", price: "20", priceType: "VB",
        startAdvertisment: Date.now,
        imageURL:
            "https://arkadiuspielka.files.wordpress.com/2024/02/71qmz4m-yjl.jpg"
    ))
    .environmentObject(UserAuthViewModel())
    .environmentObject(ProductViewModel())
    .environmentObject(MessagesViewModel())
}
