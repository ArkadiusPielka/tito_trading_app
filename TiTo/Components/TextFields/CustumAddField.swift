//
//  CustumAddField.swift
//  TiTo
//
//  Created by Arkadius Pielka on 10.01.24.
//

import SwiftUI

struct CustumAddField: View {
    
    var hint: String
    @Binding var text: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
         
                TextField(hint, text: $text)
                    .font(.title2)
            
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
    CustumAddField(hint: "Title", text: .constant("Einkaufstasche"))
}
