//
//  Message.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.02.24.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Codable, Identifiable, Equatable {
    
    @DocumentID var id: String?
    
    let senderId: String
    let recipientId: String
    let text: String
    let createdAt: Date
    let productId: String
    
    func isFormCurrentUser() -> Bool {
        guard let currentUser = FirebaseManager.shared.userId else {
            return false
        }
        
        return currentUser == senderId
     
    }
}
