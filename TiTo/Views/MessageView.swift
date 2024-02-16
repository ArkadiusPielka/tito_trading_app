//
//  MessageView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.02.24.
//

import SwiftUI

struct MessageView: View {
    
    @EnvironmentObject var chatViewModel: MessagesViewModel
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    
    var body: some View {
        
        NavigationStack {
            
            displayChatCards()
            
        }
    }
    
  
    func displayChatCards() -> some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(chatViewModel.productMessages.elements, id: \.key) { message in
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
    MessageView().environmentObject(MessagesViewModel())
        .environmentObject(UserAuthViewModel())
        .environmentObject(ProductViewModel())
}
