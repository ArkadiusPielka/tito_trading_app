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
    @StateObject var photoPickerViewModel = PhotosPickerViewModel()
    @StateObject var produktViewModel = ProduktViewModel()
    @StateObject var addressAutoCompleteViewModel = AddressAutoCompleteViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            if userAuthViewModel.userLogIn {
                NavigationView()
            } else {
                AuthenticationView()
                    .preferredColorScheme(.dark)
            }
        }
        .environmentObject(userAuthViewModel)
        .environmentObject(photoPickerViewModel)
        .environmentObject(produktViewModel)
        .environmentObject(addressAutoCompleteViewModel)
    }
}
