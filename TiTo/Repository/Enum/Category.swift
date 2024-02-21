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
    case fitness
    case food
    case car
    case crafts
    
    var title: String {
        switch self {
            
        case .videogame: return "Viedeospiele"
        case .beauty: return "Beauty"
        case .jewelry: return "Schmuck"
        case .fitness: return "Fitness"
        case .food: return "Essen"
        case .car: return "Auto"
        case .crafts: return "Handwerk"
        }
    }
    
    var image: String {
        switch self {
            
           
        case .videogame: return "gamecontroller.fill"
        case .beauty: return "theatermask.and.paintbrush.fill"
        case .jewelry: return "bubbles.and.sparkles.fill"
        case .fitness: return "figure.indoor.cycle"
        case .food: return  "fork.knife.circle"
        case .car: return "car.side.fill"
        case .crafts: return "wrench.and.screwdriver.fill"
        }
    }
}
