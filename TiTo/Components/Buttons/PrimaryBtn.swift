//
//  PrimaryBtn.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct PrimaryBtn: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                
                
        }
        .padding(.vertical, 12)
        .background(Color.accentColor)
        .cornerRadius(CGFloat.textFieldCornerRadius)
    }
}


#Preview {
    PrimaryBtn(title: "Anmelden") {}
}
