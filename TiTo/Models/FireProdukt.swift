//
//  FireProdukt.swift
//  TiTo
//
//  Created by Arkadius Pielka on 15.01.24.
//

import Foundation
import FirebaseFirestoreSwift

struct FireProdukt: Codable {
    
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
    var image: String?
    
}
