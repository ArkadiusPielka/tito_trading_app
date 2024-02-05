//
//  CheckBox.swift
//  TiTo
//
//  Created by Arkadius Pielka on 11.01.24.
//

import SwiftUI

struct CheckBox: View {
    
    @Binding var isSelected: Bool
    var text1: String
    
    var body: some View {
        HStack {
            Image(systemName: isSelected ? "circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.accentColor)
                .onTapGesture {
                    self.isSelected.toggle()
                }
            Text(text1)
            
        }
        
    }
}

#Preview {
    CheckBox(isSelected: .constant(false), text1: "Privat")
}
