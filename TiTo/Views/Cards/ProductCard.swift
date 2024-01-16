////
////  ProductCard.swift
////  TiTo
////
////  Created by Arkadius Pielka on 16.01.24.
////
//
//import SwiftUI
//
//struct ProductCard: View {
//    
//    let produkt: FireProdukt
//    
//    var body: some View {
//        
//            HStack(alignment: .top, spacing: 0) {
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: 87, height: 107)
//                    .background(
//                        AsyncImage(url: produkt.imageURL) { image in
//                            image
//                                .resizable()
//                                .frame(width: 87, height: 107)
//                                .scaledToFit()
//                                .clipped()
//                        } placeholder: {
//                            Image(systemName: "photo")
//                                .resizable()
////                                .font(.callout)
//                                .frame(width: 87, height: 107)
//                        }
//                            .multilineTextAlignment(.leading)
//                    )
//                
//                VStack(alignment: .leading) {
//                    Text(produkt.title)
//                        .font(.title2)
//                        
//                    Text(produkt.descript)
//                        .foregroundStyle(Color("subText"))
//                        .font(.footnote)
//                        .lineLimit(3)
//                    Spacer()
//                    Text(produkt.price)
//                        
//                }
//                .padding(.vertical, 8)
//                .padding(.horizontal, 12)
//                Spacer()
//            }
//            .frame(width: 350, height: 107, alignment: .top)
//            .padding(0)
//            .background(Color("cardBack"))
//            .cornerRadius(20)
//            .shadow(color: Color("subText"), radius: 4, x: -2, y: 4)
//           
//        }
//}
//
//#Preview {
//    ProductCard(produkt: FireProdukt(userId: "1", title: "Einkaufstasche", category: "", condition: "", shipment: "", description: "", advertismentType: "", price: "20", priceType: "VB"))
//}
