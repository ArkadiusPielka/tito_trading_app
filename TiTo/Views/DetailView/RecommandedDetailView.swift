//
//  RecommandedDetailView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 20.02.24.
//

import SwiftUI

struct RecommandedDetailView: View {
    
    //    @EnvironmentObject var chatViewModel: MessagesViewModel
    //    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var recomendedViewModel: RecommendedViewModel
    
    
    @State var isSendingMessage = false
    @State var text = ""
    
    var product: Recommended
    
    var body: some View {
        //        NavigationStack {
        VStack {
            
            ScrollView {
                
                AsyncImage(url: product.image) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipped()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                }
                
                .frame(maxWidth: CGFloat.maxScreenWidth, maxHeight: 300)
                .padding(.vertical, 16)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text(product.title)
                                .font(.title)
                                .bold()
                                .lineLimit(1)
                            
                            HStack {
                                Text("ab:")
                                Text("\(product.price) €")
                                Spacer()
                                
                            }
                            .font(.title2)
                            .bold()
                            
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 1)
                        .frame(maxWidth: .infinity)
                        .frame(height: 2)
                        .foregroundColor(Color("advertisment"))
                    
                    VStack(alignment: .leading ,spacing: 16) {
                        
                        Text(product.description)
                            .font(.title2)
                        
                        RoundedRectangle(cornerRadius: 1)
                            .frame(maxWidth: .infinity)
                            .frame(height: 2)                            .foregroundColor(Color("advertisment"))
                        
                        VStack(alignment: .leading ,spacing: 8) {
                            Text("Öffnungszeiten")
                                .font(.title2)
                                .bold()
                            
                            Text("Montag - Freitag")
                                .bold()
                            
                            Text(product.open ?? "09:00 - 17:00")
                            
                            if product.category == "Fitness" || product.category == "Food"{
                                Text("Samstag - Sonntag")
                                    .bold()
                                
                                Text(product.openSaturday ?? "09:00 - 13:00")
                            } else if !product.openSaturday!.isEmpty {
                                Text("Samstag")
                                    .bold()
                                
                                Text(product.openSaturday ?? "09:00 - 13:00")
                            }
                        }
                        RoundedRectangle(cornerRadius: 1)
                            .frame(maxWidth: .infinity)
                            .frame(height: 2)                            .foregroundColor(Color("advertisment"))
                        
                        Text("Anschrift")
                            .font(.title2)
                            .bold()
                        
                        VStack(alignment: .leading ,spacing: 8) {
                            Text(product.name ?? "")
                            Text(product.street ?? "")
                            HStack {
                                Text(product.plz ?? "")
                                Text(product.city ?? "")
                            }
                            HStack {
                                Text("Telefon:")
                                Text(product.call ?? "")
                            }
                            
                            
                        }
                        
                        
                        
                        PrimaryBtn(title: "Anrufen") {
                            sendMessage()
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 36)
                    }
                    .padding(.top)
                    
                }
                .padding(.horizontal)
            }
            
            
        }
    }
    
    
    func sendMessage(){
        
    }
    
}


#Preview {
    RecommandedDetailView(product: Recommended(id: 1, image: URL(string: "https://arkadiuspielka.files.wordpress.com/2024/02/5b16b-min_342a4449-b4b3-4971-b847-d5e49f095280.jpg.webp"), price: "10.99", title: "Haarverlängerung", category: "Beauty", description: "nurso"))
        .environmentObject(RecommendedViewModel())
}
