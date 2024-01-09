//
//  CustomSecureField.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct CustomSecureField: View {
    
    var hint: String
    @Binding var text: String
   
    @State private var isSecure: Bool = true
    
    
    var body: some View {
        HStack {
            if isSecure {
                SecureField(hint, text: $text)
            } else {
                TextField(hint, text: $text)
            }
            
            Button(action: {
                isSecure.toggle()
            }) {
                Image(systemName: isSecure ? "eye" : "eye.slash")
            }
            .padding(.trailing, 8)
        }
        .padding(12)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal)
    }
}

#Preview {
    CustomSecureField(hint: "Password", text: .constant(""))
}

