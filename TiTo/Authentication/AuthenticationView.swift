//
//  AuthenticationView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct AuthenticationView: View {
    
    var body: some View {
        ZStack {
            
            Image("back")
                .resizable()
                .ignoresSafeArea()
            
            LoginView()
            
        }
    }
}


#Preview {
    AuthenticationView()
}