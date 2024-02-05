//
//  Category.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.01.24.
//

import Foundation

enum Category: String, CaseIterable {
    
    case videogame
    case beauty
    case jewelry
    
    var title: String {
        switch self {
            
        case .videogame: return "Viedeospiele"
        case .beauty: return "Beauty"
        case .jewelry: return "Schmuck"
        }
    }
    
    var image: String {
        switch self {
            
        case .videogame: return "gamecontroller.fill"
        case .beauty: return "gamecontroller.fill"
        case .jewelry: return "gamecontroller.fill"
        }
    }
}
