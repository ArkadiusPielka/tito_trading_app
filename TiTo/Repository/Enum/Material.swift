//
//  Material.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.01.24.
//

import Foundation

enum Material: String, CaseIterable {
    
    case silver
    case gold
    
    var title: String {
        switch self {
        case .gold: return "Gold"
        case .silver: return "Silber"
        }
    }
}
