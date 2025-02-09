//
//  LoginView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    
    @State var email = ""
    @State var name = ""
    @State var password = ""
    
    @State var isCheckedPrivat = false
    @State var isCheckedBuisness = false
    
    @State var kontoType = ""
    
    var text: String {
        return isCheckedPrivat ? "Name" : "Firmen Name"
    }
    
    @State var mode: AuthenticationMode = .login
    
    var body: some View {
        
        VStack(spacing: 8) {
            Image("tito-inapp")
                .resizable()
                .frame(width: 250, height: 250)
            
            Text("TiTo")
                .font(.title)
            Text("Trad in & Trade out - Plattform")
                .italic()
                .font(.title2)
            
            VStack {
                if mode == .register {
                    
                    HStack {
                        CheckBox(isSelected: $isCheckedPrivat, text1: "Privat")
                        
                        CheckBox(isSelected: $isCheckedBuisness, text1: "Geschäftlich")
                        
                        Spacer()
                    }
                    .onChange(of: isCheckedPrivat) { oldValue, newValue in
                        if newValue {
                            isCheckedBuisness = false
                            kontoType = "privat Anbieter"
                        }
                    }
                    .onChange(of: isCheckedBuisness) { oldValue, newValue in
                        if newValue {
                            isCheckedPrivat = false
                            kontoType = "Geschäftskunde"
                        }
                    }
                    
                    CustomTextField(hint: text, text: $name)
                }
                
                CustomTextField(hint: "E-Mail", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                CustomSecureField(hint: "Password", text: $password)
                    .autocapitalization(.none)
                
                if mode == .login {
                    TextBtn(title: "Password vergessen", action: forgotPassword)
                        .offset(x: 75)
                }
                PrimaryBtn(title: mode.titleBtn, action: authenticate)
                
                TextBtn(title: mode.titleTextBtn, action: switchAuthenticationMode)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.8)))
            .padding()
            .rotation3DEffect(
                .degrees(mode.isFlipped ? 360 : 0),
                axis: (x: 1.0, y: 0.0, z: 0.0)
            )
          
        }
    }
    
    func forgotPassword() {
        //TODO: func einfügen
    }
    
    private func switchAuthenticationMode() {
        withAnimation {
            mode = mode == .login ? .register : .login
        }
        clearText()
        isCheckedPrivat = true
    }
    
    private func authenticate() {
        switch mode {
        case .login:
            userAuthViewModel.logIn(email: email, password: password)
            productViewModel.fetchData()
        case .register:
            userAuthViewModel.signUp(email: email, name: name, password: password, kontoType: kontoType)
        }
        clearText()
    }
    
    func clearText() {
        name = ""
        email = ""
        password = ""
        isCheckedPrivat = false
        isCheckedBuisness = false
    }
}

#Preview{
    LoginView()
        .environmentObject(UserAuthViewModel())
        .environmentObject(ProductViewModel())
}
