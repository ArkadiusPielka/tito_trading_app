//
//  ProductDetailView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 01.02.24.
//

import SwiftUI

struct ProductDetailView: View {
    
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    
    var product: FireProdukt
    
    var body: some View {
        VStack {
            ScrollView {
                AsyncImage(url: URL(string: product.imageURL ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .font(.callout)
                }
                .frame(maxWidth: CGFloat.maxScreenWidth, maxHeight: 300)
                .padding(.vertical, 16)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text(product.advertismentType)
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color("advertisment"))
                            
                            Text(product.title)
                                .font(.title)
                                .bold()
                                .lineLimit(1)
                            
                            HStack {
                                Text("\(product.price) €")
                                Text(product.priceType)
                                Spacer()
                                Text(formattedDate)
                            }
                            .foregroundColor(Color("advertisment"))
                            .font(.title2)
                            .bold()
                            if ((userAuthViewModel.productUser?.plz == "") && (userAuthViewModel.productUser?.city == "")) {
                                HStack {
                                    Text(userAuthViewModel.productUser?.plz ?? "46535")
                                    Text(userAuthViewModel.productUser?.city ?? "Dinslaken")
                                }
                            }
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 1)
                        .frame(maxWidth: .infinity)
                        .frame(height: 2)
                        .foregroundColor(Color("advertisment"))
                    
                    VStack(spacing: 16) {
                        Text(product.description)
                        
                        RoundedRectangle(cornerRadius: 1)
                            .frame(maxWidth: .infinity)
                            .frame(height: 2)                            .foregroundColor(Color("advertisment"))
                        HStack {
                            Text("Kategorie:")
                            Spacer()
                            Text(product.category)
                        }
                        
                        if product.category == "Schmuck" {
                            HStack {
                                Text("Materieal:")
                                Spacer()
                                Text(product.material ?? "")
                            }
                        }
                       
                        RoundedRectangle(cornerRadius: 1)
                            .frame(maxWidth: .infinity)
                            .frame(height: 2)
                            .foregroundColor(Color("advertisment"))
                        
                        HStack {
                            Text("Zusand:")
                            Spacer()
                            Text(product.condition)
                        }
                        RoundedRectangle(cornerRadius: 1)
                            .frame(maxWidth: .infinity)
                            .frame(height: 2)
                            .foregroundColor(Color("advertisment"))
                        HStack {
                            Text("Versand:")
                            Spacer()
                            Text(product.shipment)
                        }
                    }
                    .padding(.top)
                    
                }
                .padding(.horizontal)
            }
            
            PrimaryBtn(title: "Nachricht an \(userAuthViewModel.productUser?.name ?? "Akki")", action: sendMessage)
                .padding()
                .accentColor(Color("advertisment"))
        }
        .onAppear{
            userAuthViewModel.fetchProductUser(with: product.userId)
        }
        
    }
    func sendMessage() {
        
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInToday(product.startAdvertisment) {
            dateFormatter.locale = Locale(identifier: "de_DE")
            dateFormatter.dateFormat = "E, HH:mm"
        } else {
            dateFormatter.dateStyle = .short
        }
        
        return dateFormatter.string(from: product.startAdvertisment)
    }
}

#Preview {
    ProductDetailView(product: FireProdukt(
        userId: "1", title: "Nintendo Switch", category: "Videospiel", condition: "gut", shipment: "Versand möglich",
        description: "Die Nintendo Switch-Konsole hat einen Controller auf jeder Seite, die beide auch zusammen verwendet werden können: die Joy-Con", advertismentType: "Ich biete", price: "20", priceType: "VB",
        startAdvertisment: Date.now,
        imageURL:
            "https://arkadiuspielka.files.wordpress.com/2024/02/71qmz4m-yjl.jpg"
    ))
    .environmentObject(UserAuthViewModel())
    .environmentObject(ProductViewModel())
}
