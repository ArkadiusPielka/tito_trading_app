//
//  CustomPricingField.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.01.24.
//

import SwiftUI

struct CustomPricingField: View {
    
    var hint1: String
   
    @Binding var price: String
   
    
    var body: some View {
        
        HStack {
            HStack(alignment: .center, spacing: 0) {
                Text("Preis:")
                    .foregroundColor(Color("subText").opacity(0.6))
                
                TextField(hint1, text: $price)
                    .multilineTextAlignment(.trailing)
                Text("  €")
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(width: 150)
            .overlay(
                RoundedRectangle(cornerRadius: CGFloat.textFieldCornerRadius)
                    .stroke(Color("advertisment"), lineWidth: CGFloat.cardStroke)
            )
            Spacer()
            
        }
        .frame(width: .infinity)
    }
}

#Preview {
    CustomPricingField(hint1: "Preis",price: .constant(""))
}
