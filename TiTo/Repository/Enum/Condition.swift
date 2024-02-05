//
//  Condition.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.01.24.
//

import Foundation

enum Condition: String, CaseIterable {
    
    case new
    case verygood
    case good
    case ok
    case hobbyist
    
    var title: String {
        switch self {
            
        case .new: return "Neu"
        case .verygood: return "Sehr Gut"
        case .good: return "Gut"
        case .ok: return "In Ordnung"
        case .hobbyist: return "An Bastler"
        }
    }
    
    var subTitle: String {
        switch self {
            
        case .new: return "Unbenutzt und Originalverpackt."
        case .verygood: return "Der Artikel befindet sich in einem sehr gutem zustand, mit kaum sichtbaren Gebrauchsspuren."
        case .good: return "Der Artikel hat leicht sichtbare Gebrauchsspuren."
        case .ok: return "Der Artikel hat deutlich sichtbare Gebrauchsspuren, funktioniert aber einwandfrei."
        case .hobbyist: return "Der Artikel wird an Bastler abgegeben, da keine oder eine Eingeschränkte Funktion vorhanden ist."
        }
    }
}
