//
//  MessageInOutView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.02.24.
//

import SwiftUI

struct MessageInOutView: View {
    
    var message: Message
    
    var body: some View {
        
            if message.isFormCurrentUser() {
                VStack(alignment: .trailing) {
                    VStack(alignment: .trailing) {
                        Text(message.text)
                            .padding()
                            .foregroundColor(.white)
                          
                            .background(Color("message").opacity(0.5))
                            .cornerRadius(CGFloat.cardCornerRadius)
                    }
                    .padding(.horizontal, 16)
                    .frame(maxWidth: 280, alignment: .trailing)
                }
                .frame(maxWidth: 360, alignment: .trailing)
            } else {
                VStack(alignment: .leading) {
                    VStack {
                        Text(message.text)
                            .padding()
                            .foregroundColor(.white)
                            
                            .background(Color("cardBack"))
                            .cornerRadius(CGFloat.cardCornerRadius)
                    }
                    .padding(.horizontal, 16)
                    .frame(maxWidth: 280, alignment: .leading)
                }
                .frame(maxWidth: 360, alignment: .leading)
            }
        }
    
}

#Preview {
    MessageInOutView(message: Message(id: "11", userId: "111", recipientId: "2", text: "hallo wie geht es dir denn heute so ich wollte ", createdAt: Date()))
}
