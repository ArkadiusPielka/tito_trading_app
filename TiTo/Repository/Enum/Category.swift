//
//  Category.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.01.24.
//

import Foundation

enum Category: String, CaseIterable {
    
    case category
    case videogame
    case beauty
    case jewelry
    
    var title: String {
        switch self {
            
        case .category: return ""
        case .videogame: return "Viedeospiele"
        case .beauty: return "Beauty"
        case .jewelry: return "Schmuck"
        }
    }
}
