//
//  MessagesViewModel.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.02.24.
//
import Combine
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import Collections

enum FetchMessageError: Error {
    case snapshotError
}
class MessagesViewModel: ObservableObject {
    
    init() {
        
        listenForNewMessagesInDatabase()
    }
    
    @Published var productMessages: OrderedDictionary<String, [Message]> = [:]
    
//    func sendMessage(text: String, recipientId: String, productId: String) {
//        
//        guard let userId = FirebaseManager.shared.userId else { return }
//        
//        let conversationRef = FirebaseManager.shared.database.collection("messages").document()
//        
//        let message = Message(senderId: userId, recipientId: recipientId, text: text, createdAt: Date(), productId: productId)
//        
//        do {
//            try conversationRef.setData(from: message) { error in
//                if let error  {
//                    print("Error sending message to conversation: \(error.localizedDescription)")
//                } else {
//                   // test mit laden
//                    self.listenForNewMessagesInDatabase()
//                }
//            }
//        } catch {
//            print("Error sending message to conversation: \(error.localizedDescription)")
//        }
//    }
    
    func sendMessage(text: String, recipientId: String, senderId: String, productId: String) {
            
        let conversationRef = FirebaseManager.shared.database.collection("messages").document()
            
        let message = Message(senderId: senderId, recipientId: recipientId, text: text, createdAt: Date(), productId: productId)
            
        do {
            try conversationRef.setData(from: message) { error in
                if let error {
                    print("Error sending message to conversation: \(error.localizedDescription)")
                } else {
                    // Nachricht erfolgreich gesendet, starte den Listener für neue Nachrichten erneut
//                    self.listenForNewMessagesInDatabase()
                }
            }
        } catch {
            print("Error sending message to conversation: \(error.localizedDescription)")
        }
    }
    
   private func listenForNewMessagesInDatabase() {
        
        guard let userId = FirebaseManager.shared.userId else { return }
        
        FirebaseManager.shared.database.collection("messages").whereFilter(Filter.orFilter([
            Filter.whereField("senderId", isEqualTo: userId),
            Filter.whereField("recipientId", isEqualTo: userId)
        ]))
        .order(by: "createdAt", descending: true)
        .addSnapshotListener { [weak self] snapshot, error in
            guard let snapshot, let self = self, error == nil else {
                print("Error fetching message snapshot: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let messages = snapshot.documents.compactMap { queryDocumentSnapshot -> Message? in
                try? queryDocumentSnapshot.data(as: Message.self)
            }
            self.productMessages = OrderedDictionary(grouping: messages) { $0.productId }
        }
    }
    
}
