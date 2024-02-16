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
            ScrollView(showsIndicators: false) {
                
                ForEach(messages, id: \.id) { message in
//                    MessageInOutView(message: message)
                    if message.recipientId == userAuthViewModel.user?.id || message.senderId == userAuthViewModel.user?.id {
                            VStack(alignment: .trailing) {
                                VStack(alignment: .trailing) {
                                    Text(message.text)
                                        .padding()
                                        .foregroundColor(.white)
                                      
                                        .background(Color("message").opacity(0.5))
                                        .cornerRadius(CGFloat.cardCornerRadius)
                                }
                                .padding(.horizontal, 16)
                                .frame(maxWidth: 280, alignment: .trailing)
                            }
                            .frame(maxWidth: 360, alignment: .trailing)
                        } else {
                            VStack(alignment: .leading) {
                                VStack {
                                    Text(message.text)
                                        .padding()
                                        .foregroundColor(.white)
                                        
                                        .background(Color("cardBack"))
                                        .cornerRadius(CGFloat.cardCornerRadius)
                                }
                                .padding(.horizontal, 16)
                                .frame(maxWidth: 280, alignment: .leading)
                            }
                            .frame(maxWidth: 360, alignment: .leading)
                        }
                }
            }
            
            HStack {
                TextField("Deine Nachricht", text: $text, axis: .vertical)
                    .padding(16)
                
                if !text.isEmpty {
                    Button {
                        if let product = productViewModel.getProduct(for: productId) {
                            let recipientId = product.userId
                            let senderId =  userAuthViewModel.user?.id ?? ""

                            
                            let finalRecipientId = senderId == recipientId ? senderId : recipientId
                            
                            let finalSenderId = senderId == recipientId ? userAuthViewModel.productUser?.id ?? "" : senderId
                            
                            messagesViewModel.sendMessage(text: text, recipientId: finalRecipientId, senderId: finalSenderId, productId: productId)
                        }
                        // fehler in der id vergabe
//                        messagesViewModel.sendMessage(text: text, recipientId: selectedProduct?.userId ?? "", productId: productId)
                    }label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(Color("message"))
                    }
                }
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
