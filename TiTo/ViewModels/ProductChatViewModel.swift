//
//  ProductChatViewModel.swift
//  TiTo
//
//  Created by Arkadius Pielka on 16.02.24.
//

import Foundation

class ProductChatViewModel: ObservableObject {
    
    @Published var productId: String
    @Published var messages: [Message]
    
    init(productId: String, messages: [Message]) {
        self.messages = messages
        self.productId = productId
    }
}
