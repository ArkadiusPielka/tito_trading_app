//
//  ProduktViewModel.swift
//  TiTo
//
//  Created by Arkadius Pielka on 15.01.24.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProduktViewModel: ObservableObject {
    
    private var listener: ListenerRegistration?
    
    @Published var produkts = [FireProdukt]()
    
    @Published var title = ""
    @Published var category = ""
    @Published var condition = ""
    @Published var shipment = ""
    @Published var optional = ""
    @Published var description = ""
    @Published var advertismentType = "Ich biete"
    @Published var material = ""
    @Published var price = ""
    @Published var priceType = ""
    @Published var optionals = ""
    @Published var imageURL = ""
    
    
    func createProduct() {
        guard let userId = FirebaseManager.shared.userId else { return }
        
        let product = FireProdukt(userId: userId,
                                  title: title,
                                  category: category,
                                  condition: condition,
                                  shipment: shipment,
                                  optional: optional ,
                                  description: description,
                                  advertismentType: advertismentType,
                                  material: material,
                                  price: price,
                                  priceType: priceType,
                                  imageURL: imageURL
                                  
        )

        do {
            try FirebaseManager.shared.database.collection("products").addDocument(from: product)
        } catch let error {
            print("Fehler beim Speichern des Tasks: \(error)")
        }
    }
    
    func uploadImage(image: Data, completion: @escaping (String?) -> Void) {
        let storage = FirebaseManager.shared.storage.reference()
        
        let path = "images/\(UUID().uuidString).jpeg"
        let fileRef = storage.child(path)
        
        let uploadTask = fileRef.putData(image, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                
                fileRef.downloadURL { url, error in
                    guard let downloadURL = url, error == nil else {
                        print("Fehler beim Abrufen der Download-URL: \(error!.localizedDescription)")
                        completion(nil)
                        return
                    }
                    
                    let imageURL = downloadURL.absoluteString
                    
                    completion(imageURL)
                    
                    print("Download-URL des hochgeladenen Bilds: \(downloadURL)")
                }
            } else {
                print("Fehler beim Hochladen des Bildes: \(error?.localizedDescription ?? "Unbekannter Fehler")")
                completion(nil)
            }
        }
    }
    
    
    func fetchProdukt() {
        guard let userId = FirebaseManager.shared.userId else { return }
        
        self.listener = FirebaseManager.shared.database.collection("products")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("Fehler beim Laden der Tasks")
                    return
                }
                
                self.produkts = documents.compactMap { queryDocumentSnapshot -> FireProdukt? in
                    try? queryDocumentSnapshot.data(as: FireProdukt.self)
                }
            }
    }
}
