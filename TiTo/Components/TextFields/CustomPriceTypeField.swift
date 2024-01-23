//
//  CustomPriceTypeField.swift
//  TiTo
//
//  Created by Arkadius Pielka on 15.01.24.
//

import SwiftUI

struct CustomPriceTypeField: View {
    
    var hint2: String
    @Binding var priceType: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("Preistyp:")
                .foregroundColor(Color("subText").opacity(0.6))
            TextField(hint2, text: $priceType)
                .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
            Image(systemName: "chevron.right")
                .foregroundColor(Color("advertisment"))
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(width: 180)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("advertisment"), lineWidth: CGFloat.cardStroke)
        )
    }
}

#Preview {
    CustomPriceTypeField(hint2: "PreisTyp", priceType: .constant("VB"))
}
