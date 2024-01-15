//
//  CustomTextEdidField.swift
//  TiTo
//
//  Created by Arkadius Pielka on 11.01.24.
//

import SwiftUI

struct CustomTextEdidField: View {
    
    @Binding var description: String
    var text: String
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            if description.isEmpty {
                VStack {
                    Text("Beschreibung")
                        .font(.title2)
                        .padding(.top, 8)
                        .opacity(0.6)
                    Spacer()
                }
            }
            
            VStack {
                TextEditor(text: $description)
                    .font(.title2)
                    .opacity(description.isEmpty ? 0.6 : 1)
                Spacer()
            }
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
    CustomTextEdidField(description: .constant(""), text: "Beschreibung")
}
