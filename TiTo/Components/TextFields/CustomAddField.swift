//
//  CustomAddField.swift
//  TiTo
//
//  Created by Arkadius Pielka on 10.01.24.
//

import SwiftUI

struct CustomAddField: View {

  var hint: String
  @Binding var text: String
  var strokeColor: Color

  var body: some View {

    VStack(alignment: .leading, spacing: 6) {

      TextField(hint, text: $text)
        .font(.title2)

    }
    .padding(.horizontal, 16)
    .padding(.vertical, 8)
    .frame(maxWidth: .infinity, alignment: .leading)
    .overlay(
      RoundedRectangle(cornerRadius: CGFloat.textFieldCornerRadius)
        .stroke(strokeColor, lineWidth: CGFloat.cardStroke)
    )
  }
}

#Preview{
    CustomAddField(hint: "Title", text: .constant("Einkaufstasche"), strokeColor: Color("advertisment"))
}

