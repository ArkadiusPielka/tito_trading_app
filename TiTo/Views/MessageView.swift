//
//  MessageView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.02.24.
//

import SwiftUI

struct MessageView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if let product = productViewModel.currentProduct {
                    // NavigationLink zur ChatView
                    NavigationLink(destination: ChatView(product: product)) {
                        ChatCard(product: product)
                            .environmentObject(chatViewModel)
                            .environmentObject(userAuthViewModel)
                            .environmentObject(productViewModel)
                    }
                } else {
                    Text("Produkt nicht gefunden")
                }
            }
            .onAppear{
                chatViewModel.loadExistingConversations()
            }
        }
    }
}

#Preview {
    MessageView().environmentObject(ChatViewModel())
        .environmentObject(UserAuthViewModel())
        .environmentObject(ProductViewModel())
}
