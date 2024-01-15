//
//  AdvertisementView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct AdvertisementView: View {
    
    @EnvironmentObject var photosPicker: PhotosPickerViewModel
    
    @State var title = ""
    @State var category = ""
    @State var condition = ""
    @State var shipment = ""
    @State var optional = ""
    @State var description = ""
    @State var advertismentType = ""
    @State var material = ""
    @State var price = ""
    @State var priceType = ""
    @State var optionals = ""
    
    @State var iOffer = true
    @State var iSearch = false
    
    @State var categorySheet = false
    @State var conditionSheet = false
    @State var shipmentSheet = false
    @State var materialSheet = false
    @State var priceTypeSheet = false
    @State var optionalSheet = false
    
    var body: some View {
        NavigationStack {
            
            GeometryReader { proxy in
                ScrollView {
                    VStack {
                        // Image
                        VStack {
                            if let imageData = photosPicker.selectedImage {
                                Image(uiImage: imageData)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.size.width, height: 400)
                                
                            } else {
                                Image("produkt1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.size.width, height: 400)
                                
                            }
                        }
                        
                        VStack(spacing: 24) {
                            ImagePickerView()
                                .padding(.top, 24)
                            HStack {
                                CheckBox(isSelected: $iOffer, text1: "Ich biete")
                                CheckBox(isSelected: $iSearch, text1: "Ich suche")
                                Spacer()
                            }
                            .accentColor(Color("advertisment"))
                            .onChange(of: iOffer) { oldValue, newValue in
                                if newValue  {
                                    iSearch = false
                                    advertismentType = "Ich biete"
                                }
                            }
                            .onChange(of: iSearch) { oldValue, newValue in
                                if newValue {
                                    iOffer = false
                                    advertismentType = "Ich suche"
                                }
                            }
                            
                            CustomAddField(hint: "Titel", text: $title)
                            
                            CustomAddFieldNav(hint: "Kategory", text: $category)
                                .onTapGesture {
                                    categorySheet.toggle()
                                }
                            
                            if category == "Schmuck" {
                                CustomAddFieldNav(hint: "Material", text: $material)
                                    .onTapGesture {
                                        materialSheet.toggle()
                                    }
                            }
                            
                            CustomAddFieldNav(hint: "Zustand", text: $condition)
                                .onTapGesture {
                                    conditionSheet.toggle()
                                }
                            
                            CustomAddFieldNav(hint: "Versand", text: $shipment)
                                .onTapGesture {
                                    shipmentSheet.toggle()
                                }
                            
                            CustomTextEdidField(description: $description, text: "Beschreibung")
                                .frame(minHeight: 150)
                            HStack {
                                CustomPricingField(hint1: "Preis", price: $price)
                                CustomPriceTypeField(hint2: "Preistyp", priceType: $priceType)
                                    .onTapGesture {
                                        priceTypeSheet.toggle()
                                    }
                            }
                            
                            CustomAddFieldNav(hint: "Optional", text: $optional)
                                .onTapGesture {
                                    optionalSheet.toggle()
                                }
                            
                            PrimaryBtn(title: "Anzeige aufgeben", action: startAdd)
                            Spacer(minLength: 100)
                        }
                        .padding(.horizontal)
                    }
                    
                    .sheet(isPresented: $categorySheet) {
                        CategoryView(category: $category, categorySheet: $categorySheet) { categorySelected in
                            category = categorySelected
                        }
                    }
                    .sheet(isPresented: $conditionSheet) {
                        ConditionView(condition: $condition, conditionSheet: $conditionSheet) { conditionSelected in
                            condition = conditionSelected
                        }
                    }
                    .sheet(isPresented: $shipmentSheet) {
                        ShipmentView(shipment: $shipment, shipmentSheet: $shipmentSheet) { shipmentSelected in
                            shipment = shipmentSelected
                        }
                    }
                    .sheet(isPresented: $materialSheet) {
                        MaterialView(material: $material, materialSheet: $materialSheet) { materialSelected in
                            material = materialSelected
                        }
                    }
                    .sheet(isPresented: $priceTypeSheet) {
                        PriceTypeView(priceType: $priceType, priceTypeSheet: $priceTypeSheet) { priceTypeSelected in
                            priceType = priceTypeSelected
                        }
                        .presentationDetents([.fraction(0.35)])
                    }
                    .sheet(isPresented: $optionalSheet) {
                        OptionalOptionsView(option: $optional, optionSheet: $optionalSheet) { optionalSelected in
                            optional = optionalSelected
                        }
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
        .environmentObject(PhotosPickerViewModel())
}
