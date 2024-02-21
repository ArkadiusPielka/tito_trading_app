//
//  HomeView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var recomendenViewModel = RecommendedViewModel()
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    
    @State var searchText = ""
    @State var searchCategory = ""
    @State var showFilter = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                CustomSearchView(searchText: $searchText, searchCategory: $searchCategory, showFilter: $showFilter)
                
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Empfohlen")
                            .multilineTextAlignment(.leading)
                            .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
                            .padding(.horizontal, 16)
                        
                        ScrollView(.horizontal) {
                            
                            LazyHStack(spacing: 8) {
                                let filteredProducts = recomendenViewModel.article.filter { (searchCategory == "" || $0.category == searchCategory) }
                                if !filteredProducts.isEmpty {
                                    ForEach(filteredProducts, id: \.id) { produkt in
                                        NavigationLink(destination: RecommandedDetailView(product: produkt)) {
                                            RecommendedCard(product: produkt)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    .padding(.top, 8)
                                    .padding(.bottom, 16)
                                    .padding(.leading, 16)
                                } else {
                                    VStack {
                                        Text("Suche ergab keinen Treffer.")
                                            .foregroundColor(.primary)
                                            .padding()
                                    }
                                    .frame(width: CGFloat.recomendedWidth, height: CGFloat.cardHeight, alignment: .center)
                                    .background(Color("cardBack"))
                                    .cornerRadius(CGFloat.cardCornerRadius)
                                    .shadow(color: Color("subText"), radius: 4, x: -2, y: 4)
                                    .padding(.leading, 16)
                                    .padding(.bottom, 16)
                                }
                            }
                        }
                        
                        Text("Weitere Anzeigen")
                            .multilineTextAlignment(.leading)
                            .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
                            .padding(.horizontal, 16)
                        
                        LazyVStack(spacing: 16) {
                            let filteredProducts = productViewModel.products.filter { $0.userId != userAuthViewModel.user?.id && (searchCategory == "" || $0.category == searchCategory) && (searchText == "" || $0.title.contains(searchText)) }
                            
                            let sortedProducts = filteredProducts.sorted(by: { $0.startAdvertisment > $1.startAdvertisment })
                            
                            if !sortedProducts.isEmpty {
                                ForEach(sortedProducts, id: \.id) { product in
                                    NavigationLink(destination: ProductDetailView(product: product)) {
                                        ProductCard(product: product, color: Color("subText"))
                                            .foregroundColor(.primary)
                                    }
                                }
                            } else {
                                VStack {
                                    Text("Keine Produkte gefunden.")
                                        .foregroundColor(.primary)
                                        .padding()
                                }
                                .frame(maxWidth: .infinity, alignment: .top)
                                .frame(height: CGFloat.cardHeight)
                                .background(Color("cardBack"))
                                .clipShape(RoundedRectangle(cornerRadius: CGFloat.cardCornerRadius))
                                .shadow(color: Color("subText"), radius: 4, x: -2, y: 4)
                                .padding(.horizontal, 16)
                            }
                        }
                        .onAppear{
                            productViewModel.fetchAllProducts()
                        }
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
