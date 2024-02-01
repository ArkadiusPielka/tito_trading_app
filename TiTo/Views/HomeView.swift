//
//  HomeView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var recomendenViewModel = RecommendenViewModel()
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    
    @State var search = ""
    @State var showFilter = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                CustomSearchView(searchText: $search, showFilter: $showFilter)
                
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Empfohlen")
                            .multilineTextAlignment(.leading)
                            .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
                            .padding(.horizontal, 16)
                        
                        ScrollView(.horizontal) {
                            
                            LazyHStack(spacing: 8) {
                                
                                ForEach(recomendenViewModel.article, id: \.id) { produkt in
                                    RecommendedCard(product: produkt)
                                }
                                .padding(.top, 8)
                                .padding(.bottom, 16)
                                .padding(.leading, 16)
                            }
                        }
                        
                        Text("Weitere Anzeigen")
                            .multilineTextAlignment(.leading)
                            .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
                            .padding(.horizontal, 16)
                        
                        LazyVStack(spacing: 16) {
                            ForEach(productViewModel.products.filter { $0.userId != userAuthViewModel.user?.id }, id: \.id) { product in
                                ProductCard(product: product)
                            }
                            .frame(width: .infinity, height: CGFloat.cardHeight, alignment: .top)
                            .background(Color("cardBack"))
                            .cornerRadius(CGFloat.cardCornerRadius)
                            .shadow(color: Color("subText"), radius: 4, x: -2, y: 4)
                            .environmentObject(userAuthViewModel)
                        }
                        .padding(.horizontal, 16)
                        Spacer(minLength: 20)
                    }
                }
            }
        }
    }
}

#Preview{
    HomeView()
        .environmentObject(ProductViewModel())
        .environmentObject(UserAuthViewModel())
}
