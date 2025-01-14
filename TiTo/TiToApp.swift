//
//  TiToApp.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI
import Firebase

@main
struct TiToApp: App {
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    @StateObject var userAuthViewModel = UserAuthViewModel()
    @StateObject var produktViewModel = ProductViewModel()
    @StateObject var chatViewModel = MessagesViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            if userAuthViewModel.userLogIn {
                NavigationView()
            } else {
                AuthenticationView()
            }
        }
        .environmentObject(userAuthViewModel)
        .environmentObject(produktViewModel)
        .environmentObject(chatViewModel)
    }
}
