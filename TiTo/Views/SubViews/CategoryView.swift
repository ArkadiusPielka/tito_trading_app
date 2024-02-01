//
//  CategoryView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.01.24.
//

import SwiftUI

struct CategoryView: View {
    
    @Binding var category: String
    @Binding var categorySheet: Bool
    var selectedCategory: (String) -> Void
    
    var body: some View {
        VStack {
            Text("Kategory")
                .padding(.vertical, CGFloat.sheetTitleVertical)
            
            List(Category.allCases, id: \.self) { category in
                Button(action: {
                    selectedCategory(category.title)
                    categorySheet = false
                }) {
                    Text(category.title)
                        .foregroundColor(.primary)
                        .font(.title2)
                        
                }
            }
        }
    }
}

#Preview {
    CategoryView(category: .constant("Viedeospiel"), categorySheet: .constant(false), selectedCategory: {_ in })
}
