//
//  ProduktViewModel.swift
//  TiTo
//
//  Created by Arkadius Pielka on 15.01.24.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProductViewModel: ObservableObject {
    
    init() {
        fetchAllProducts()
        fetchProdukt()
    }
    
    private var listener: ListenerRegistration?
    
    @Published var products = [FireProdukt]()
    @Published var userProducts = [FireProdukt]()
    @Published var userFavoriteProducts = [FireProdukt]()
    
    @Published var currentProduct: FireProdukt?
    
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
    @Published var startAdvertisment = Date.now
    @Published var productUserId = ""
    @Published var productId = ""
    
    @Published var selectedImage: PhotosPickerItem?
    @Published var selectedImageData: Data?
    
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
                                  startAdvertisment: startAdvertisment
                                  
        )
        
        do {
            let documentReference = try FirebaseManager.shared.database.collection("products").addDocument(from: product)
            
            let id = documentReference.documentID
            productUserId = userId
            productId = id
            print(id)
            updateImage(id: id)
            
        } catch let error {
            print("Fehler beim Speichern des Products: \(error)")
        }

        fetchAllProducts()
    }
    
    func updateImage(id: String) {
        
        guard let userId = FirebaseManager.shared.userId, let selectedImageData = selectedImageData else { return }
        
        // Referenz erstellen zum Speicherort des Bildes
        let reference = FirebaseManager.shared.storage.reference().child(userId).child("productImages").child("\(id).jpg")
        
        reference.putData(selectedImageData, metadata: nil) { _, error in
            if let error {
                print("Image upload failed!", error)
                return
            }
            
            self.getImageURL(from: reference, id: id)
        }
    }
    
    private func getImageURL(from reference: StorageReference, id: String) {
        
        reference.downloadURL { url, error in
            if let error {
                print("Image upload failed!", error)
                return
            }
            
            guard let url else {
                print("We don't have a URL, something went wrong!")
                return
            }
            
            let data = ["imageURL": url.absoluteString]
            self.updateProduct(id: id, with: data)
        }
    }
    
    private func updateProduct(id: String, with data: [String: String]) {
        FirebaseManager.shared.database.collection("products").document(id).setData(data, merge: true) { error in
            if let error {
                print("Task wurde nicht aktualisiert", error.localizedDescription)
                return
            }
            
            print("Task aktualisiert!")
        }
    }
    
    func updateProductDetails(id: String, product: FireProdukt) {
        
        guard let userId = FirebaseManager.shared.userId else { return }
        
        let product = ["title": product.title,
                    "category": product.category,
                    "condition": product.condition,
                    "shipment": product.shipment,
                    "optional": product.optional,
                    "description": product.description,
                    "material": product.material,
                       "price": product.price,
                       "priceType": product.priceType
                      
        ]
        FirebaseManager.shared.database.collection("products").document(id).setData(product as [String : Any], merge: true) { error in
            if let error {
                print("Profil wurde nicht aktualisiert", error.localizedDescription)
                return
            }
            
            print("Profil aktualisiert!")
        }
        updateImage(id: userId)
        fetchAllProducts()
    }
    
    func fetchAllProducts() {
        
        FirebaseManager.shared.database.collection("products")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching all products: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                self.products = documents.compactMap { queryDocumentSnapshot -> FireProdukt? in
                    try? queryDocumentSnapshot.data(as: FireProdukt.self)
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
                
                self.userProducts = documents.compactMap { queryDocumentSnapshot -> FireProdukt? in
                    try? queryDocumentSnapshot.data(as: FireProdukt.self)
                }
            }
    }
    
    func updateProductList() {
        self.listener = FirebaseManager.shared.database.collection("products")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching products: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                self.products = documents.compactMap { queryDocumentSnapshot -> FireProdukt? in
                    try? queryDocumentSnapshot.data(as: FireProdukt.self)
                }
            }
    }
    
    func removeListener() {
        userProducts.removeAll()
        listener?.remove()
    }
    
    func deleteAdvertisment(with id: String) {
        
        guard let userId = FirebaseManager.shared.userId else { return }
        
        
        FirebaseManager.shared.storage.reference().child(userId).child("productImages").child("\(id).jpg").delete { error in
            if let error {
                print("Bild für Task kann nicht gelöscht werden", error)
                return
            }
        }
        
        FirebaseManager.shared.database.collection("products").document(id).delete() { error in
            if let error {
                print("Task kann nicht gelöscht werden", error)
                return
            }
            
            print("Task mit ID \(id) gelöscht")
        }
    }
    
    func getProduct(for id: String) -> FireProdukt? {
        return products.first { $0.id == id }
    }
    
    func setCurrentProduct(_ product: FireProdukt) {
            self.currentProduct = product
        }
}

