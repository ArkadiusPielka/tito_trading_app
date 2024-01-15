//
//  Shipment.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.01.24.
//

import Foundation

enum Shipment: String, CaseIterable {
    
    case no
    case yes
   
    
    var title: String {
        switch self {
            
        case .no: return "Nur Abholung"
        case .yes: return "Versand möglich"
       
        }
    }
}
