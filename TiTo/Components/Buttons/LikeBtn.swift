//
//  LikeBtn.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct LikeBtn: View {
    
    let action: () -> Void
    
    @State var like = false
    @State var image = "heart"
    
    var body: some View {
        
        Button(action: action) {
            Image(systemName: image)
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(.red)
                .onTapGesture {
                    like.toggle()
                    image = like ? "heart.fill" : "heart"
                }
        }
        //        .background(content: {
        //            Circle()
        //                .frame(width: 52, height: 52, alignment: .center)
        //                .background(.clear)
        //                .foregroundColor(Color("cardBack"))
        //                .offset(y: -2)
        //        })
    }
}

#Preview {
    LikeBtn() {}
}



