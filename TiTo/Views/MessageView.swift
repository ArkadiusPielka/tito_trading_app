//
//  MessageView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.02.24.
//

import SwiftUI

struct MessageView: View {
    
    @EnvironmentObject var messagesViewModel: MessagesViewModel
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    
    var body: some View {
        
        NavigationStack {
            
            VStack(alignment: .leading) {
                Group {
                    Text("Deine Chats")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    RoundedRectangle(cornerRadius: 1)
                        .frame(maxWidth: .infinity)
                        .frame(height: 2)
                        .foregroundColor(Color("message").opacity(0.6))
                        .padding(.bottom, 16)
                }
                .padding(.horizontal, 16)
                Spacer()
                VStack {
                    if messagesViewModel.productMessages.isEmpty {
                        HStack {
                            Spacer()
                            VStack(alignment: .center, spacing: 26) {
                                Spacer()
                                Image(systemName: "message.fill")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text("Sie haben keine Activen Chats")
                                    .font(.title2)
                                    .italic()
                                
                                Spacer()
                            }
                            .foregroundColor(Color("message").opacity(0.6))
                            
                            Spacer()
                        }
                    } else {
                        displayChatCards()
                    }
                }
            }
        }
        
    }
    
    
    func displayChatCards() -> some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(messagesViewModel.productMessages.elements, id: \.key) { message in
                    NavigationLink(destination: ChatView(productId: message.key)) {
                        if let pdoduct = productViewModel.getProduct(for: message.key){
                            ChatCard(product: pdoduct)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    MessageView()
        .environmentObject(MessagesViewModel())
        .environmentObject(UserAuthViewModel())
        .environmentObject(ProductViewModel())
}
