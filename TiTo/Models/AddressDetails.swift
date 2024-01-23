//
//  address.swift
//  TiTo
//
//  Created by Arkadius Pielka on 23.01.24.
//

import Foundation

struct AddressDetails: Codable {
    
    var housenumber: String
    var street: String
    var country: String
    var city: String
    var postcode: String
}
