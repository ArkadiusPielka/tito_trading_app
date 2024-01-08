//
//  Tab.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import Foundation
import SwiftUI


enum Tab: String, CaseIterable {
    
    case home
    case message
    case advertisement
    case favorites
    case profile
    
    var title: String {
        switch self {
            
        case .home: return "Home"
        case .message: return "Nachricht"
        case .advertisement: return "Anzeige"
        case .favorites: return "Favoriten"
        case .profile: return "Profile"
        }
    }
    
    var image: String {
        switch self {
            
        case .home: return "house.fill"
        case .message: return "message.fill"
        case .advertisement: return "plus.app.fill"
        case .favorites: return "heart.fill"
        case .profile: return "person.fill"
        }
    }
    
    var color: Color {
        switch self {
            
        case .home: return .white
        case .message: return Color("message")
        case .advertisement: return Color("advertisment")
        case .favorites: return Color("favorite")
        case .profile: return Color("profil")
        }
    }
    
    func getMainView() -> some View {
           switch self {
           case .home:
               return AnyView(HomeView())
           case .message:
               return AnyView(MessageView())
           case .advertisement:
               return AnyView(AdvertisementView())
           case .favorites:
               return AnyView(FavoritesView())
           case .profile:
               return AnyView(ProfileView())
           }
       }
    
    var index: CGFloat {
        return CGFloat(Tab.allCases.firstIndex(of: self) ?? 0)
    }
    
    static var count: CGFloat {
        return CGFloat(Tab.allCases.count)
    }
}

