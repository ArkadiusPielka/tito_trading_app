//
//  CustomTextField.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct CustomTextField: View {
    
    var hint: String
    @Binding var text: String

    var body: some View {
        TextField(hint, text: $text)
            .padding(12)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            .padding(.horizontal)
    }
}

#Preview {
    CustomTextField(hint: "Benutzername", text: .constant(""))
}
