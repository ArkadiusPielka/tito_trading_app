//
//  MaterialView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.01.24.
//

import SwiftUI

struct MaterialView: View {
    
    @Binding var material: String
    @Binding var materialSheet: Bool
    var selectedMaterial: (String) -> Void
    
    var body: some View {
        VStack {
            Text("Kategory")
            
            List(Material.allCases, id: \.self) { material in
                Button(action: {
                    selectedMaterial(material.title)
                    materialSheet = false
                }) {
                    Text(material.title)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

#Preview {
    MaterialView(material: .constant(""), materialSheet: .constant(false), selectedMaterial: {_ in})
}
