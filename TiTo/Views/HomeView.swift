//
//  HomeView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var recomendenViewModel = RecommendenViewModel()
    @State var search = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Empfohlen")
                    .multilineTextAlignment(.leading)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                ScrollView(.horizontal){
                    HStack(spacing: 16) {
                        ForEach(recomendenViewModel.article, id: \.id) { produkt in
                            RecommendedCard(produkt: produkt)
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                        
}
                    
                }
                Text("Weitere Anzeigen")
                    .multilineTextAlignment(.leading)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            .padding(.leading, 16)
            .searchable(text: $search)
        }
        
    }
}

#Preview {
    HomeView()
}
