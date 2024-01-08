//
//  TextBtn.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct TextBtn: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    TextBtn(title: "hallo") {}
}
