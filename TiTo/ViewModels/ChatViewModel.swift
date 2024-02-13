//
//  ChatViewModel.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.02.24.
//
import Combine
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

enum FetchMessageError: Error {
    case snapshotError
}
class ChatViewModel: ObservableObject {
    
    init() {
        listenForNewMessageInDatabase()
        listenForNewMessages()
        loadExistingConversations()
        print(messages.count)
    }
    
    @Published var messages = [Message]()
    @Published var currentMessage: Message?
    
    private var messageListener: ListenerRegistration?
    
    func setCurrentMessage(_ message: Message) {
        currentMessage = message
        listenForNewMessages()
    }
    
    func listenForNewMessages() {
        guard let currentMessageId = currentMessage?.id else {
            return
        }
        
        messageListener?.remove()
        
        let conversationRef = FirebaseManager.shared.database.collection("message")
            .document(currentMessageId)
            .collection("messages")
        messageListener = conversationRef
            .order(by: "createdAt", descending: false)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let snapshot = snapshot else {
                    print("Error fetching message snapshot: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                self?.messages = snapshot.documents.compactMap { document in
                    try? document.data(as: Message.self)
                }
            }
    }
    
    func sendFirstMessage(text: String, recipientId: String, productId: String, completion: @escaping (Bool) -> Void) {
        guard let userId = FirebaseManager.shared.userId else {
            completion(false)
            return
        }
        
        let messageId = [userId, recipientId]
        
        let conversationRef = FirebaseManager.shared.database.collection("message").document(productId).collection(messageId.joined(separator: "_")).document()
        
        let data: [String: Any] = [
            "text": text,
            "userId": userId,
            "recipientId": recipientId,
            "createdAt": Timestamp(date: Date())
        ]
        
        // Add the message to the conversation document
        conversationRef.setData(data) { error in
            if let error = error {
                print("Error sending message to conversation: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Message sent to conversation successfully")
                // Update the local messages list with the new message
                self.messages.append(Message(id: messageId.joined(separator: "_"), userId: userId, recipientId: recipientId, text: text, createdAt: Date()))
                completion(true)
            }
        }
    }
    
    func listenForNewMessageInDatabase() {
        guard let userId = FirebaseManager.shared.userId else { return }
        FirebaseManager.shared.database.collection("message")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdAt", descending: true)
            .limit(to: 25)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let snapshot = snapshot, let strongSelf = self, error == nil else {
                    return
                }
                let messages = strongSelf.createMessageFromFirebaseSnapshot(snapshot: snapshot)
                strongSelf.messages = messages
            }
    }
    func createMessageFromFirebaseSnapshot(snapshot: QuerySnapshot) -> [Message] {
        //        var messages = [Message]()
        for document in snapshot.documents {
            let data = document.data()
            if let userId = data["userId"] as? String,
               let recipientId = data["recipientId"] as? String,
               let text = data["text"] as? String,
               let createdAtTimestamp = data["createdAt"] as? Timestamp {
                let messageId = userId + recipientId
                let createdAt = createdAtTimestamp.dateValue()
                messages.append(Message(id: messageId, userId: userId, recipientId: recipientId, text: text, createdAt: createdAt))
            }
        }
        return messages
    }
    
    func loadExistingConversations() {
        guard let userId = FirebaseManager.shared.userId else {
            return
        }
        
        FirebaseManager.shared.database.collection("message")
            .whereField("messageId", arrayContains: userId) 
            .order(by: "createdAt", descending: true)
            .limit(to: 25)
            .getDocuments { [weak self] snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    return
                }
                let messages = self?.createMessageFromFirebaseSnapshot(snapshot: snapshot) ?? []
                self?.messages = messages
                
                
            }
    }
}

