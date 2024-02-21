//
//  LikeBtn.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct LikeBtn: View {
    var isLiked: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(.red)
        }
    }
}

#Preview {
    LikeBtn(isLiked: true) {}
}



