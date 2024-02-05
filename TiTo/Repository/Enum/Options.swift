//
//  OptionalOptions.swift
//  TiTo
//
//  Created by Arkadius Pielka on 15.01.24.
//

import Foundation

enum Options: String, CaseIterable {
    
   case normal
    
    var title: String {
        switch self {
            
      
        case .normal: return "Normal"
           
        }
    }
    
    var subTitle: String {
        switch self {
            
        
        case .normal: return "normal"
        }
    }
}

