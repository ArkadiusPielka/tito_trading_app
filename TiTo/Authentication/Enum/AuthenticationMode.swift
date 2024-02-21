//
//  AuthenticationMode.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import Foundation

enum AuthenticationMode {
    case login, register
    
    var titleBtn: String {
        switch self {
        case .login: return "Anmelden"
        case .register: return "Registrieren"
        }
    }
    
    var titleTextBtn: String {
        switch self {
        case .login: return "Noch kein Konto? Registrieren →"
        case .register: return "Schon registriert? Anmelden →"
        }
    }
    
    var isFlipped: Bool {
            self == .register
        }
    
    
}
