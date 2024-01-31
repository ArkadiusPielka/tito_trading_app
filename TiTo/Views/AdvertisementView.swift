//
//  AdvertisementView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI
import PhotosUI

struct AdvertisementView: View {
    
    @EnvironmentObject var photosPicker: PhotosPickerViewModel
    @EnvironmentObject var produktViewModel: ProduktViewModel
    
    @State var iOffer = true
    @State var iSearch = false
    
    @State var categorySheet = false
    @State var conditionSheet = false
    @State var shipmentSheet = false
    @State var materialSheet = false
    @State var priceTypeSheet = false
    @State var optionalSheet = false
    
    var isButtonEnabled: Bool {
        return produktViewModel.selectedImage != nil &&
        !produktViewModel.title.isEmpty &&
        !produktViewModel.category.isEmpty &&
        !produktViewModel.condition.isEmpty &&
        !produktViewModel.shipment.isEmpty &&
        !produktViewModel.price.isEmpty &&
        !produktViewModel.description.isEmpty &&
        !produktViewModel.priceType.isEmpty
        
    }
    
    var body: some View {
        NavigationStack {
            
            GeometryReader { proxy in
                ScrollView {
                    VStack {
                        // Image
                        VStack {
                            if let imageData = produktViewModel.selectedImageData, let image = UIImage(data: imageData){
                                
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.size.width, height: 400)
                            } else {
                                PlaceholderView(icon: "photo.fill", title: "")
                                    .frame(width: proxy.size.width, height: 400)
                            }
                        }
                        
                        VStack(spacing: 16) {
                            PhotosPicker(selection: $produktViewModel.selectedImage, matching: .images, preferredItemEncoding: .automatic) {
                                
                                Image(systemName: "camera.fill")
                                    .resizable()
                                    .frame(width: 40, height: 30)
                            }
                            .padding(.top, 24)
                            HStack {
                                CheckBox(isSelected: $iOffer, text1: "Ich biete")
                                CheckBox(isSelected: $iSearch, text1: "Ich suche")
                                Spacer()
                            }
                            .accentColor(Color("advertisment"))
                            .onChange(of: iOffer) { oldValue, newValue in
                                if newValue {
                                    iSearch = false
                                    produktViewModel.advertismentType = "Ich biete"
                                }
                            }
                            .onChange(of: iSearch) { oldValue, newValue in
                                if newValue {
                                    iOffer = false
                                    produktViewModel.advertismentType = "Ich suche"
                                }
                            }
                            
                            CustomAddField(hint: "Titel", text: $produktViewModel.title, strokeColor: Color("advertisment"))
                               
                            
                            CustomAddFieldNav(hint: "Kategorie", text: $produktViewModel.category, strokeColor: Color("advertisment"))
                                .onTapGesture {
                                    categorySheet.toggle()
                                }
                            
                            if produktViewModel.category == "Schmuck" {
                                CustomAddFieldNav(hint: "Material", text: $produktViewModel.material, strokeColor: Color("advertisment"))
                                    .onTapGesture {
                                        materialSheet.toggle()
                                    }
                            }
                            
                            CustomAddFieldNav(hint: "Zustand", text: $produktViewModel.condition, strokeColor: Color("advertisment"))
                                .onTapGesture {
                                    conditionSheet.toggle()
                                }
                            
                            CustomAddFieldNav(hint: "Versand", text: $produktViewModel.shipment, strokeColor: Color("advertisment"))
                                .onTapGesture {
                                    shipmentSheet.toggle()
                                }
                            
                            CustomTextEdidField(description: $produktViewModel.description, text: "Beschreibung")
                                .frame(minHeight: 150)
                            
                            HStack {
                                CustomPricingField(hint1: "Preis", price: $produktViewModel.price)
                                CustomPriceTypeField(hint2: "Preistyp", priceType: $produktViewModel.priceType)
                                    .onTapGesture {
                                        priceTypeSheet.toggle()
                                    }
                            }
                            
                            CustomAddFieldNav(hint: "Optional", text: $produktViewModel.optional, strokeColor: Color("advertisment"))
                                .onTapGesture {
                                    optionalSheet.toggle()
                                }
                            
                            PrimaryBtn(title: "Anzeige aufgeben", action: startAdd)
                                .disabled(!isButtonEnabled)
                            
                            Spacer(minLength: 20)
                        }
                        .padding(.horizontal)
                    }
                    
                    .sheet(isPresented: $categorySheet) {
                        CategoryView(category: $produktViewModel.category, categorySheet: $categorySheet) {
                            categorySelected in
                            produktViewModel.category = categorySelected
                        }
                        .presentationDetents([.fraction(0.35)])
                    }
                    
                    .sheet(isPresented: $conditionSheet) {
                        ConditionView(condition: $produktViewModel.condition, conditionSheet: $conditionSheet) {
                            conditionSelected in
                            produktViewModel.condition = conditionSelected
                        }
                    }
                    
                    .sheet(isPresented: $shipmentSheet) {
                        ShipmentView(shipment: $produktViewModel.shipment, shipmentSheet: $shipmentSheet) {
                            shipmentSelected in
                            produktViewModel.shipment = shipmentSelected
                        }
                        .presentationDetents([.fraction(0.35)])
                    }
                    
                    .sheet(isPresented: $materialSheet) {
                        MaterialView(material: $produktViewModel.material, materialSheet: $materialSheet) {
                            materialSelected in
                            produktViewModel.material = materialSelected
                        }
                        .presentationDetents([.fraction(0.35)])
                    }
                    
                    .sheet(isPresented: $priceTypeSheet) {
                        PriceTypeView(priceType: $produktViewModel.priceType, priceTypeSheet: $priceTypeSheet) {
                            priceTypeSelected in
                            produktViewModel.priceType = priceTypeSelected
                        }
                        .presentationDetents([.fraction(0.35)])
                    }
                    
                    .sheet(isPresented: $optionalSheet) {
                        OptionalOptionsView(option: $produktViewModel.optional, optionSheet: $optionalSheet) {
                            optionalSelected in
                            produktViewModel.optional = optionalSelected
                        }
                    }
                }
                .onChange(of: produktViewModel.selectedImage) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            produktViewModel.selectedImageData = data
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
    
    func startAdd() {
        produktViewModel.createProduct()
        cleareFields()
    }
    
    func cleareFields() {
        produktViewModel.selectedImage = nil
        produktViewModel.title = ""
        produktViewModel.category = ""
        produktViewModel.condition = ""
        produktViewModel.shipment = ""
        produktViewModel.description = ""
        produktViewModel.price = ""
        produktViewModel.priceType = ""
        produktViewModel.material = ""
        produktViewModel.optional = ""
    }
}

#Preview{
    AdvertisementView()
        .environmentObject(PhotosPickerViewModel())
        .environmentObject(ProduktViewModel())
}
