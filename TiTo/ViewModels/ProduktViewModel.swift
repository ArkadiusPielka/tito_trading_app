//
//  ProduktViewModel.swift
//  TiTo
//
//  Created by Arkadius Pielka on 15.01.24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProduktViewModel: ObservableObject {
    
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
    @Published var image = ""
    
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
                                  image: image
        )
        
        do {
            try FirebaseManager.shared.database.collection("products").addDocument(from: product)
        } catch let error {
            print("Fehler beim Speichern des Tasks: \(error)")
        }
    }
}
