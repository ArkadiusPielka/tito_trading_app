//
//  NavigationBtn.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct NavigationBtn<Destination: View>: View {
    
    var title: String
    var destination: Destination
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            NavigationLink(destination: destination) {
                Text(title)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    NavigationBtn(title: "Nachricht senden", destination: HomeView()) {}
}
