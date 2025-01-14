//
//  FireUser.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import Foundation

struct FireUser: Codable {
    
    var id: String
    var name: String
    var email: String
    var registeredAt: Date
    var kontoType: String
    var plz: String?
    var housenumber: String?
    var street: String?
    var country: String?
    var city: String?
    var imageURL: String?
    
}


