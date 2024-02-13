//
//  Message.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.02.24.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Codable, Identifiable {
    
    @DocumentID var id: String?
    
//    let conversationId: String
    
    let userId: String
    let recipientId: String
    let text: String
    let createdAt: Date
    
    func isFormCurrentUser() -> Bool {
        guard let currentUser = FirebaseManager.shared.userId else {
            return false
        }
        
        if currentUser == userId {
            return true
        } else {
            return false
        }
    }
    
    var dictionary: [String: Any] {
            return [
                "userId": userId,
                "recipientId": recipientId,
                "text": text,
                "createdAt": createdAt
            ]
        }
}
