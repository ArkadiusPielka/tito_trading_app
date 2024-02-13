//
//  ChatView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct ChatView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    @State var text = ""
    
    var product: FireProdukt
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(chatViewModel.messages, id: \.id) { message in
                    MessageInOutView(message: message)
                }
            }
            HStack {
                TextField("Deine Nachricht", text: $text, axis: .vertical)
                    .padding(16)
                    
                if !text.isEmpty {
                    Button {
                        chatViewModel.sendFirstMessage(text: text, recipientId: productViewModel.currentProduct?.userId ?? "", productId: product.id ?? "") { succses in
                            if succses {
                                print(text)
                                text = ""
                                
                            } else {
                                print("fehler beim senden der nachricht")
                            }
                        }
                    }label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(Color("message"))
                    }
                }
            }
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: CGFloat.cardCornerRadius)
                    .stroke(Color("message"), lineWidth: 1)
            )
        }
        .onAppear {
            productViewModel.setCurrentProduct(product)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 26)
//        .onChange(of: text) {  newText in
//            text = newText
//        }
    }
}

#Preview {
    ChatView(
        product: FireProdukt(
            userId: "1", title: "Einkaufstascheasdasdad", category: "", condition: "VB", shipment: "",
            description: "", advertismentType: "Ich biete", price: "20", priceType: "VB",
            startAdvertisment: Date.now,
            imageURL:
                "https://arkadiuspielka.files.wordpress.com/2024/02/71qmz4m-yjl.jpg"
        ))
    .environmentObject(ChatViewModel())
    .environmentObject(ProductViewModel())
}
