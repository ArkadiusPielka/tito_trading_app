//
//  ChatView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct ChatView: View {
    
    @EnvironmentObject var messagesViewModel: MessagesViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    
    var productId: String
    
    var messages: [Message] {
        let unsortedMessages = messagesViewModel.productMessages.elements.first(where: { $0.key == productId } )?.value ?? []
        return unsortedMessages.sorted { $0.createdAt < $1.createdAt }
    }
    
    var selectedProduct: FireProduct? {
        productViewModel.products.first(where: { $0.id == productId } )
    }
    
    @State var text = ""
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: selectedProduct?.imageURL ?? "")) { image in
                    image
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaledToFit()
                        .clipped()
                } placeholder: {
                    Image("ring")
                        .resizable()
                        .font(.callout)
                        .frame(width: 50, height: 50)
                }
             
                VStack(alignment: .leading) {
                    Text(selectedProduct?.title ?? "ring")
                    
                    HStack(spacing: 10) {
                      
                        Text(selectedProduct?.price ?? "20")
                        Text(selectedProduct?.priceType ?? "VB")
                    }
                    .foregroundColor(Color("message"))
                }
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 1)
                .frame(maxWidth: .infinity)
                .frame(height: 2)
                .foregroundColor(Color("message").opacity(0.6))
            ScrollView(showsIndicators: false) {
                
                ForEach(messages, id: \.id) { message in
                    MessageInOutView(message: message)
                }
            }
            .padding(.top, 16)
            
            HStack {
                TextField("Deine Nachricht", text: $text, axis: .vertical)
                    .padding(16)
                
                if !text.isEmpty {
                    Button {
                        var senderId = ""
                        var recipientId = ""
                        
                        if let product = selectedProduct {
                            senderId = userAuthViewModel.user?.id ?? ""
                            recipientId = product.userId
                        }
                        
                        if messages.isEmpty {
                            messagesViewModel.sendMessage(text: text, recipientId: recipientId, senderId: senderId, productId: productId)
                            
                        } else {
                            
                            let firstMessage = messages.first!
                            
                            if firstMessage.senderId == senderId {
                                messagesViewModel.sendMessage(text: text, recipientId: recipientId, senderId: senderId, productId: productId)
                            } else {
                                messagesViewModel.sendMessage(text: text, recipientId: firstMessage.senderId, senderId: senderId, productId: productId)
                            }
                        }
                        text = ""
                        
                    }label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(Color("message"))
                    }
                }
            }
            .onSubmit {
                var senderId = ""
                var recipientId = ""
                
                if let product = selectedProduct {
                    senderId = userAuthViewModel.user?.id ?? ""
                    recipientId = product.userId
                }
                
                if messages.isEmpty {
                    messagesViewModel.sendMessage(text: text, recipientId: recipientId, senderId: senderId, productId: productId)
                    
                } else {
                    
                    let firstMessage = messages.first!
                    
                    if firstMessage.senderId == senderId {
                        messagesViewModel.sendMessage(text: text, recipientId: recipientId, senderId: senderId, productId: productId)
                    } else {
                        messagesViewModel.sendMessage(text: text, recipientId: firstMessage.senderId, senderId: senderId, productId: productId)
                    }
                }
                text = ""
            }
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: CGFloat.cardCornerRadius)
                    .stroke(Color("message"), lineWidth: 1)
            )
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 26)
    }
}

#Preview {
    ChatView(productId: "")
        .environmentObject(MessagesViewModel())
        .environmentObject(ProductViewModel())
        .environmentObject(UserAuthViewModel())
}
