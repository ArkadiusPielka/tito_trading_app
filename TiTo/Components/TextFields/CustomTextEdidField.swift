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
        
        ZStack{
            
            TextEditor(text: $description)
           
            HStack(alignment: .top) {
                VStack {
                    if description.isEmpty{
                        Text(text)
                            .font(.title2)
                            .foregroundColor(.gray)
                            .opacity(0.5)
//                            .padding(.vertical,8)
//                            .padding(.horizontal,4)
                    }
                    Spacer()
                }
                Spacer()
            }
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
    CustomTextEdidField(description: .constant(""), text: "Beschreibung")
}
