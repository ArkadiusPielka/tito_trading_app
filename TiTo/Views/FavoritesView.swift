//
//  FavoritesView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                Group {
                    Text("Deine Favoriten")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    RoundedRectangle(cornerRadius: 1)
                        .frame(maxWidth: .infinity)
                        .frame(height: 2)
                        .foregroundColor(Color("favorite").opacity(0.6))
                        .padding(.bottom, 16)
                }
                .padding(.horizontal, 16)
                Spacer()
                VStack {
                    if productViewModel.userFavoriteProducts.isEmpty {
                        HStack {
                            Spacer()
                            VStack(alignment: .center, spacing: 26) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text("Sie haben keine Favoriten")
                                    .font(.title2)
                                    .italic()
                                
                                Spacer()
                            }
                            .foregroundColor(Color("favorite").opacity(0.6))
                            
                            Spacer()
                        }
                    } else {
                        displayFavoriteProductCards()
                    }
                }
            }
        }
    }
    
    func displayFavoriteProductCards() -> some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(productViewModel.userFavoriteProducts, id: \.id) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        if let pdoduct = productViewModel.getProduct(for: product.id ?? "") {
                            ProductCard(product: pdoduct, color: Color("favorite"))
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(ProductViewModel())
        .environmentObject(UserAuthViewModel())
}
