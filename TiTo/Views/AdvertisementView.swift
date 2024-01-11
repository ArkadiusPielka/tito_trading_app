//
//  AdvertisementView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct AdvertisementView: View {
    
    @StateObject var photosPicker = PhotosPickerViewModel()
    
    @State var title = ""
    @State var category = ""
    @State var condition = ""
    @State var shipment = ""
    @State var optional = ""
    @State var description = ""
    
    @State var iOffer = true
    @State var iSearch = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                
                ScrollView {
                    
                    VStack(spacing: 24) {
                        if let imageData = photosPicker.selectedImage {
                            Image(uiImage: imageData)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: 400)
                        } else {
                            Image("produkt1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: 400)
                        }
                            
                        HStack {
                            CheckBox(isSelected: $iOffer, text1: "Ich biete")
                                
                            CheckBox(isSelected: $iSearch, text1: "Ich suche")
                            Spacer()
                        }
                        .accentColor(Color("advertisment"))
                        .onChange(of: iOffer) { oldValue, newValue in
                            if newValue  {
                                iSearch = false
//                                kontoType = "privat Anbieter"
                            }
                        }
                        .onChange(of: iSearch) { oldValue, newValue in
                            if newValue {
                                iOffer = false
//                                kontoType = "Geschäftskunde"
                            }
                        }
                        
                        
                        CustumAddField(hint: "Titel", text: $title)
                        CustomAddFieldNav(hint: "Kategory", text: $category)
                        CustomAddFieldNav(hint: "Zustand", text: $condition)
                        CustomAddFieldNav(hint: "Versand", text: $shipment)
                       CustomTextEdidField(description: $description, text: "Beschreibung")
                            .frame(minHeight: 150)
                        
                        PrimaryBtn(title: "Anzeige aufgeben", action: startAdd)
                            .padding(.horizontal)
                        Spacer(minLength: 100)
                    }
                }
                .edgesIgnoringSafeArea(.top)
                
            }
        }
    }
    
    func startAdd(){
        
    }
}

#Preview {
    AdvertisementView()
}
