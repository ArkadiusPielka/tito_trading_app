//
//  ProductCard.swift
//  TiTo
//
//  Created by Arkadius Pielka on 16.01.24.
//

import SwiftUI

struct ProductCard: View {
    
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject var messagesViewModel: MessagesViewModel
    
    var product: FireProduct
    
    var color: Color
    
    @State private var isEditing = false
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            
            if isCurrentUserProduct() {
                SwipeActionView(actions: [
                    Action(color: .blue, name: "Edit", systemIcon: "pencil", action: {
                        isEditing.toggle()
                    }),
                    Action(color: .red, name: "Delete", systemIcon: "trash.fill", action: { showAlert.toggle()
                    })
                ]) {
                    content
                }
            } else {
                content
            }
        }
        
        .frame(maxWidth: .infinity, alignment: .top)
        .frame(height: CGFloat.cardHeight)
        .background(Color("cardBack"))
        .clipShape(RoundedRectangle(cornerRadius: CGFloat.cardCornerRadius))
        .shadow(color: color, radius: 4, x: -2, y: 4)
        .padding(.horizontal, 16)
        
        .fullScreenCover(isPresented: $isEditing) {
            ProductEditView(product: product)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Anzeige löschen"), message: Text("Möchten Sie diese Anzeige wirklich löschen?"), primaryButton: .destructive(Text("Löschen")) {
                delete()
            }, secondaryButton: .cancel(Text("Abbrechen")))
        }
    }
    
    var content: some View {
        ZStack {
            VStack {
                Spacer()
                if !isCurrentUserProduct() {
                    HStack {
                        Spacer()
                        LikeBtn(isLiked: product.isFavorite) {
                            productViewModel.toggleLike(for: product)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 6)
            HStack(alignment: .top, spacing: 0) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: CGFloat.cardWidth, height: CGFloat.cardHeight)
                    .background(
                        AsyncImage(url: URL(string: product.imageURL ?? "")) { image in
                            image
                                .resizable()
                                .frame(width: CGFloat.cardWidth, height: CGFloat.cardHeight)
                                .scaledToFit()
                                .clipped()
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .font(.callout)
                                .frame(width: CGFloat.cardWidth, height: CGFloat.cardHeight)
                        }
                    )
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Group {
                            Text(product.advertismentType)
                            Spacer()
                            Text(formattedDate)
                        }
                        .foregroundStyle(Color("subText"))
                        .font(.footnote)
                        .font(.title3)
                    }
                    
                    Text(product.title)
                        .font(.title2)
                        .lineLimit(1)
                    
                    HStack {
                        Text("\(product.price) €")
                        Text(product.priceType)
                            .bold()
                        Spacer()
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
            }
        }
    }
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        
        let currentDate = Date()
        
        if Calendar.current.isDateInToday(product.startAdvertisment) {
            dateFormatter.locale = Locale(identifier: "de_DE")
            dateFormatter.dateFormat = "E, HH:mm"
        } else {
            dateFormatter.dateStyle = .short
        }
        
        return dateFormatter.string(from: product.startAdvertisment)
    }
    
    func isCurrentUserProduct() -> Bool {
        guard let currentUserID = userAuthViewModel.user?.id else { return false }
        return product.userId == currentUserID
    }
    
    func delete() {
        productViewModel.deleteAdvertisment(with: product.id!)
        messagesViewModel.deleteMessages(with: product.id!)
    }
}

#Preview {
    ProductCard(
        product: FireProduct(
            userId: "1", title: "Einkaufstascheasdasdad", category: "", condition: "VB", shipment: "",
            description: "", advertismentType: "Ich biete", price: "20", priceType: "VB",
            startAdvertisment: Date.now,
            imageURL:
                "https://arkadiuspielka.files.wordpress.com/2024/02/71qmz4m-yjl.jpg"
        ), color: .advertisment)
    .environmentObject(UserAuthViewModel())
    .environmentObject(ProductViewModel())
    .environmentObject(MessagesViewModel())
}
