//
//  CustomSearchView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 24.01.24.
//

import SwiftUI

struct CustomSearchView: View {
    
    @Binding var searchText: String
    @Binding var showFilter: Bool
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $searchText)
                        .foregroundColor(.primary)
                    
                    if !searchText.isEmpty  {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.blue)
                                .opacity(searchText.isEmpty ? 0 : 1)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                Button {
                    showFilter.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            if showFilter {
                ScrollView(.horizontal) {
                HStack(spacing: 26) {
                    
                        ForEach(Category.allCases, id:\.self) { category in
                            
                            Button {
                                // TODO: func
                            } label: {
                                VStack {
                                    Image(systemName: category.image)
                                        .font(.title2)
                                    Text(category.title)
                                }
                                .foregroundColor(.primary)
                            }
                        }
                    }
                }
                .padding(.leading)
            }
        }
    }
}


#Preview {
    CustomSearchView(searchText: .constant(""), showFilter: .constant(true))
}