//
//  PriceType.swift
//  TiTo
//
//  Created by Arkadius Pielka on 15.01.24.
//

import Foundation

enum PriceType: String, CaseIterable {
    
    case vb
    case fp
    
    var title: String {
        switch self {
        case .vb: return "VB"
        case .fp: return "FP"
        }
    }
    
    var subTitle: String {
        switch self {
        case .vb: return "Verhandlungsbasis"
        case .fp: return "Festpreis"
        }
    }
}
