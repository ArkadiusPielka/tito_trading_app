//
//  LoginView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var name = ""
    @State var password = ""
    
    @State var mode: AuthenticationMode = .login
    
    var body: some View {
        
        VStack(spacing: 12) {
            CustomTextField("E-Mail", text: $email)
            
            if mode == .register {
                CustomTextField("Name", text: $name)
            }
            
            CustomSecureField("Password", text: $password)
            PrimaryBtn(title: mode.titleBtn, action: authenticate)
                .padding(.horizontal)
            TextBtn(title: mode.titleTextBtn, action: switchAuthenticationMode)
        }
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.8)))
        .padding()
        .rotation3DEffect(
            .degrees(mode.isFlipped ? 360 : 0),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
    
    private func switchAuthenticationMode() {
        withAnimation {
            mode = mode == .login ? .register : .login
        }
        clearText()
    }
    
    private func authenticate() {
//        switch mode {
//        case .login:
//            userAuthViewModel.logIn(email: email, password: password)
//        case .register:
//            userAuthViewModel.signUp(email: email, name: name, password: password)
//        }
        clearText()
    }
    
    func clearText() {
        name = ""
        email = ""
        password = ""
    }
}

#Preview {
    LoginView()
}
