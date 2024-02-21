//
//  FireProduct.swift
//  TiTo
//
//  Created by Arkadius Pielka on 15.01.24.
//

import Foundation
import FirebaseFirestoreSwift

struct FireProduct: Codable, Identifiable, Equatable {
    
    @DocumentID var id: String?
    
    var userId: String
    var title: String
    var category: String
    var condition: String
    var shipment: String
    var optional: String?
    var description: String
    var advertismentType: String
    var material: String?
    var price: String
    var priceType: String
    var startAdvertisment: Date
    var imageURL: String?
    var isFavorite: Bool = false
    
    var dictionary: [String: Any] {
        return [
            "id": id ?? "",
            "userId": userId,
            "title": title,
            "category": category,
            "condition": condition,
            "shipment": shipment,
            "optional": optional ?? "",
            "description": description,
            "advertismentType": advertismentType,
            "material": material ?? "",
            "price": price,
            "priceType": priceType,
            "startAdvertisment": startAdvertisment,
            "imageURL": imageURL ?? "",
            "isFavorite" : isFavorite
        ]
    }
}
