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
    
    var body: some View {
        HStack(spacing: 6) {
         
                TextField(hint, text: $text)
                    .font(.title2)
            Image(systemName: "chevron.right")
                .foregroundColor(Color("advertisment"))
        }
       
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(width: 360, alignment: .leading)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("advertisment"))
        )
    
    }
}

#Preview {
    CustomAddFieldNav(hint: "Kategory", text: .constant(""))
}
