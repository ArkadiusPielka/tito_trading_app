//
//  ProfileView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    
    @State var showDetails = false
    @State var showAdvertisment = false
    @State var showSettings = false
    
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    Group {
                        UserDetailView(showDetails: $showDetails)
                            .animation(
                                .easeInOut(duration: 2)
                                .delay(1),
                                value: 2
                            )
                    }
                    
                    VStack(alignment: .leading) {
                        
                        if !productViewModel.userProducts.isEmpty {
                            
                            HStack {
                                Text("Deine Inserate")
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                Text("(\(productViewModel.userProducts.count))")
                                    .font(.title2)
                                Spacer()
                                
                                Button {
                                    withAnimation {
                                        self.showAdvertisment.toggle()
                                    }
                                } label: {
                                    Image(systemName: showAdvertisment ? "chevron.up" : "chevron.down")
                                        .animation(.interactiveSpring)
                                }
                                .buttonStyle(.plain)
                            }
                            
                            if showAdvertisment {
                                
                                    RoundedRectangle(cornerRadius: 1)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 2)
                                        .foregroundColor(Color("profil"))
                                        .padding(.bottom, 16)
                                    LazyVStack(spacing: 16) {
                                        
                                        let userProducts = productViewModel.userProducts
                                        
                                        let sortedProducts = userProducts.sorted(by: { $0.startAdvertisment > $1.startAdvertisment })
                                        
                                        ForEach(sortedProducts) { product in
                                            ProductCard(product: product, color: Color("profil"))
                                            
                                        }
                                    }
                                    .animation(.linear, value: showAdvertisment)
                                    .padding(.bottom)
                                
                            }
                        } else {
                            VStack(alignment: .center) {
                                Image(systemName: "doc.text")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text("Du hast keine Inserate")
                                    .font(.title2)
                                    .italic()
                            }
                            .foregroundColor(Color.profil)
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: CGFloat.cardCornerRadius)
                            .inset(by: 0.5)
                            .stroke(Color("profil"))
                    )
                }
                .toolbar {
                    Button {
                        showSettings.toggle()
                    }label: {
                        Image(systemName: "gear")
                            .foregroundColor(Color("profil"))
                    }
                    .padding(.bottom)
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView(showSettings: $showSettings)
                        .presentationDetents([.fraction(0.35)])
                }
                .onAppear{
                    productViewModel.fetchUserProducts()
                }
                
                Spacer(minLength: 20)
            }
            .padding(.horizontal)
        }
    }
    
    func userDetails() {
        withAnimation(.easeInOut(duration: 0.4)) {
            self.showDetails.toggle()
        }
    }
    
}

#Preview{
    ProfileView()
        .environmentObject(UserAuthViewModel())
        .environmentObject(ProductViewModel())
    
}
