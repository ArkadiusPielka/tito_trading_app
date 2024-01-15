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
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
         
                TextField(hint, text: $text)
                    .font(.title2)
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(width: .infinity, alignment: .leading)
        
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("advertisment"))
        )
    }
}

#Preview {
    CustomAddField(hint: "Title", text: .constant("Einkaufstasche"))
}
