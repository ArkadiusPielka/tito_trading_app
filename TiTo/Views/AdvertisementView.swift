//
//  AdvertisementView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI
import PhotosUI

struct AdvertisementView: View {
    
    @EnvironmentObject var productViewModel: ProductViewModel
    
    @State var iOffer = true
    @State var iSearch = false
    
    
    @State var categorySheet = false
    @State var conditionSheet = false
    @State var shipmentSheet = false
    @State var materialSheet = false
    @State var priceTypeSheet = false
    @State var optionalSheet = false
    @State var showAlert = false
    
    var isButtonEnabled: Bool {
        return productViewModel.selectedImage != nil &&
        !productViewModel.title.isEmpty &&
        !productViewModel.category.isEmpty &&
        !productViewModel.condition.isEmpty &&
        !productViewModel.shipment.isEmpty &&
        !productViewModel.price.isEmpty &&
        !productViewModel.description.isEmpty &&
        !productViewModel.priceType.isEmpty
        
    }
    
    var body: some View {
        
        NavigationStack {
            
            GeometryReader { proxy in
                
                ScrollView {
                    
                    VStack {
                        VStack {
                            if let imageData = productViewModel.selectedImageData, let image = UIImage(data: imageData){
                                
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.size.width, height: 400)
                            } else {
                                PlaceholderView(icon: "photo.fill", title: "")
                                    .frame(width: proxy.size.width, height: 400)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            PhotosPicker(selection: $productViewModel.selectedImage, matching: .images, preferredItemEncoding: .automatic) {
                                if productViewModel.selectedImage != nil {
                                    HStack {
                                        if let imageData = productViewModel.selectedImageData, let image = UIImage(data: imageData){
                                            
                                            Image(uiImage: image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 40, height: 30)
                                            Rectangle()
                                                .frame(width: 2, height: 30)
                                                .foregroundColor(Color("advertisment"))
                                            Image(systemName: "camera.fill")
                                                .resizable()
                                                .frame(width: 40, height: 30)
                                        }
                                    }
                                }else {
                                    Image(systemName: "camera.fill")
                                        .resizable()
                                        .frame(width: 40, height: 30)
                                }
                                
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
                                    productViewModel.advertismentType = "Ich biete"
                                }
                            }
                            .onChange(of: iSearch) { oldValue, newValue in
                                if newValue {
                                    iOffer = false
                                    productViewModel.advertismentType = "Ich suche"
                                }
                            }
                            
                            CustomAddField(hint: "Titel", text: $productViewModel.title, strokeColor: Color("advertisment"))
                            
                            
                            CustomAddFieldNav(hint: "Kategorie", text: $productViewModel.category, strokeColor: Color("advertisment"))
                                .onTapGesture {
                                    categorySheet.toggle()
                                }
                            
                            if productViewModel.category == "Schmuck" {
                                CustomAddFieldNav(hint: "Material", text: $productViewModel.material, strokeColor: Color("advertisment"))
                                    .onTapGesture {
                                        materialSheet.toggle()
                                    }
                            }
                            
                            CustomAddFieldNav(hint: "Zustand", text: $productViewModel.condition, strokeColor: Color("advertisment"))
                                .onTapGesture {
                                    conditionSheet.toggle()
                                }
                            
                            CustomAddFieldNav(hint: "Versand", text: $productViewModel.shipment, strokeColor: Color("advertisment"))
                                .onTapGesture {
                                    shipmentSheet.toggle()
                                }
                            
                            CustomTextEdidField(description: $productViewModel.description, text: "Beschreibung")
                                .frame(minHeight: 150)
                            
                            HStack {
                                CustomPricingField(hint1: "Preis", price: $productViewModel.price)
                                CustomPriceTypeField(hint2: "Preistyp", priceType: $productViewModel.priceType)
                                    .onTapGesture {
                                        priceTypeSheet.toggle()
                                    }
                            }
                            
                            CustomAddFieldNav(hint: "Optional", text: $productViewModel.optional, strokeColor: Color("advertisment"))
                                .onTapGesture {
                                    optionalSheet.toggle()
                                }
                            
                            PrimaryBtn(title: "Anzeige aufgeben", action: alertPresented)
                                .disabled(!isButtonEnabled)
                                .alert("Anzeige aufgeben", isPresented: $showAlert) {
                                    Button("Ja, jetzt aufgeben", action: { startAdd() })
                                    Button("Abbrechen", role: .cancel, action: { showAlert.toggle() })
                                    Button("Anzeige verwerfen", role: .destructive, action: { cleareFields() })
                                }
                            
                            Spacer(minLength: 20)
                        }
                        .padding(.horizontal)
                    }
                    
                    .sheet(isPresented: $categorySheet) {
                        CategoryView(category: $productViewModel.category, categorySheet: $categorySheet) {
                            categorySelected in
                            productViewModel.category = categorySelected
                        }
                        .presentationDetents([.fraction(0.55)])
                        .presentationDragIndicator(.visible)
                    }
                    
                    .sheet(isPresented: $conditionSheet) {
                        ConditionView(condition: $productViewModel.condition, conditionSheet: $conditionSheet) {
                            conditionSelected in
                            productViewModel.condition = conditionSelected
                        }
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                    }
                    
                    .sheet(isPresented: $shipmentSheet) {
                        ShipmentView(shipment: $productViewModel.shipment, shipmentSheet: $shipmentSheet) {
                            shipmentSelected in
                            productViewModel.shipment = shipmentSelected
                        }
                        .presentationDetents([.fraction(0.35)])
                        .presentationDragIndicator(.visible)

                    }
                    
                    .sheet(isPresented: $materialSheet) {
                        MaterialView(material: $productViewModel.material, materialSheet: $materialSheet) {
                            materialSelected in
                            productViewModel.material = materialSelected
                        }
                        .presentationDetents([.fraction(0.35)])
                        .presentationDragIndicator(.visible)

                    }
                    
                    .sheet(isPresented: $priceTypeSheet) {
                        PriceTypeView(priceType: $productViewModel.priceType, priceTypeSheet: $priceTypeSheet) {
                            priceTypeSelected in
                            productViewModel.priceType = priceTypeSelected
                        }
                        .presentationDetents([.fraction(0.35)])
                        .presentationDragIndicator(.visible)

                    }
                    
                    .sheet(isPresented: $optionalSheet) {
                        OptionsView(option: $productViewModel.optional, optionSheet: $optionalSheet) {
                            optionalSelected in
                            productViewModel.optional = optionalSelected
                        }
                        .presentationDetents([.fraction(0.35)])
                        .presentationDragIndicator(.visible)
                    }
                }
                .onChange(of: productViewModel.selectedImage) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            productViewModel.selectedImageData = data
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
    
    func alertPresented() {
        showAlert.toggle()
    }
    
    func startAdd() {
        productViewModel.createProduct()
        productViewModel.fetchAllProducts()
        cleareFields()
    }
    
    func cleareFields() {
        productViewModel.selectedImage = nil
        productViewModel.selectedImageData = nil
        productViewModel.title = ""
        productViewModel.category = ""
        productViewModel.condition = ""
        productViewModel.shipment = ""
        productViewModel.description = ""
        productViewModel.price = ""
        productViewModel.priceType = ""
        productViewModel.material = ""
        productViewModel.optional = ""
    }
}

#Preview{
    AdvertisementView()
        .environmentObject(ProductViewModel())
}
