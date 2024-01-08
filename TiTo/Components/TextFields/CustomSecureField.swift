//
//  CustomSecureField.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct CustomSecureField: View {
    
    var placeholder: String
      @Binding var text: String
      @State private var displayedText: String = ""
      @State private var isSecure: Bool = true

      init(_ placeholder: String, text: Binding<String>) {
          self.placeholder = placeholder
          self._text = text
          self._displayedText = State(initialValue: text.wrappedValue)
      }

      var body: some View {
          HStack {
              if isSecure {
                  SecureField(placeholder, text: $displayedText)
              } else {
                  TextField(placeholder, text: $displayedText)
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
    CustomSecureField("Password", text: .constant(""))
}

