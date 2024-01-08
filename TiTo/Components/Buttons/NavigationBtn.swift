//
//  NavigationBtn.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

    struct NavigationBtn<Content: View>: View {
        
        let destination: Content
        let label: String

        init(destination: Content, label: String) {
            self.destination = destination
            self.label = label
        }

        var body: some View {
            NavigationLink(destination: destination) {
                Text(label)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }

#Preview {
    NavigationBtn(destination: HomeView(), label: "Nachricht senden")
}
