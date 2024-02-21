//
//  Country.swift
//  TiTo
//
//  Created by Arkadius Pielka on 23.01.24.
//

import Foundation

enum Country: String, CaseIterable {
    
    case german
    case usa
    
    var title: String {
        switch self {
      
        case .german: return "Deutschland"
        case .usa: return "USA"
           
        }
    }
}
