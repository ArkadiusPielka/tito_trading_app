//
//  CustomAddFieldNav.swift
//  TiTo
//
//  Created by Arkadius Pielka on 11.01.24.
//

import SwiftUI

struct CustomAddFieldNav: View {
    
    var hint: String
    @Binding var text: String
    var strokeColor: Color
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 6) {
                
                TextField(hint, text: $text)
                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .font(.title2)
                Image(systemName: "chevron.right")
                    .foregroundColor(strokeColor)
            }
            
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(width: .infinity,  alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: CGFloat.textFieldCornerRadius)
                    .stroke(strokeColor, lineWidth: CGFloat.cardStroke)
            )
        }
        .frame(height: 50)
    }
}

#Preview {
    CustomAddFieldNav(hint: "Kategory", text: .constant(""), strokeColor: Color("advertisment"))
}
