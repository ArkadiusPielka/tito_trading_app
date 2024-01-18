//
//  PlaceholderView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct PlaceholderView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .font(.largeTitle)
            
            Text(title)
                .font(.body)
        }
    }
    
    
    
    // MARK: - Variables
    
    let icon: String
    let title: String
    
}

#Preview {
    PlaceholderView(icon: "plus.circle.fill", title: "Keine Orte")
}
