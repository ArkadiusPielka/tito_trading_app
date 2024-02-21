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
    
    func sendMessage(text: String, recipientId: String, senderId: String, productId: String) {
        
        let conversationRef = FirebaseManager.shared.database.collection("messages").document()
        
        let message = Message(senderId: senderId, recipientId: recipientId, text: text, createdAt: Date(), productId: productId)
        
        do {
            try conversationRef.setData(from: message) { error in
                if let error {
                    print("Error sending message to conversation: \(error.localizedDescription)")
                } else {
                    
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
    
    func deleteMessages(with productId: String) {
        
        let messagesForProduct = FirebaseManager.shared.database.collection("messages")
            .whereField("productId", isEqualTo: productId)
        
        messagesForProduct.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents found.")
                    return
                }
                
                for document in documents {
                    document.reference.delete { error in
                        if let error = error {
                            print("Error deleting document: \(error)")
                        } else {
                            print("Document successfully deleted.")
                        }
                    }
                }
            }
        }
    }
}
