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
    
    var body: some View {
        
        VStack {
            CustomTextField("E-Mail", text: $email)
            CustomSecureField("Password", text: $password)
        }
    }
}

#Preview {
    LoginView()
}
