//
//  ProductEditView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 05.02.24.
//

import SwiftUI
import PhotosUI

struct ProductEditView: View {
    
    @EnvironmentObject var productViewModel: ProductViewModel
    
    var product: FireProduct
    
    @State var selectedImage: PhotosPickerItem?
    @State var selectedImageData: Data?
    
    @State var categorySheet = false
    @State var conditionSheet = false
    @State var shipmentSheet = false
    @State var materialSheet = false
    @State var priceTypeSheet = false
    @State var optionalSheet = false
    @State var showAlert = false
    
    @State var title = ""
    @State var category = ""
    @State var condition = ""
    @State var shipment = ""
    @State var optional = ""
    @State var description = ""
    @State var material = ""
    @State var priceType = ""
    @State var price = ""
    @State var optionals = ""
    @State var imageURL = ""
    
    var body: some View {
        
        VStack {
            ScrollView {
                AsyncImage(url: URL(string: product.imageURL ?? "")) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .success(let image):
                        if let selectedImage = productViewModel.selectedImageData, let image = UIImage(data: selectedImage) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: CGFloat.maxScreenWidth, maxHeight: 300)
                        } else {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: CGFloat.maxScreenWidth, maxHeight: 300)
                        }
                    case .failure:
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    @unknown default:
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(maxWidth: CGFloat.maxScreenWidth, maxHeight: 300)
                .padding(.vertical, 16)
                
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
                    .onChange(of: productViewModel.selectedImage) { _, newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                productViewModel.selectedImageData = data
                            }
                        }
                    }

                    CustomAddField(hint: "Titel", text: $title, strokeColor: Color("advertisment"))
                    
                    CustomAddFieldNav(hint: "Kategorie", text: $category, strokeColor: Color("advertisment"))
                        .onTapGesture {
                            categorySheet.toggle()
                        }
                    
                    if productViewModel.category == "Schmuck" {
                        CustomAddFieldNav(hint: "Material", text: $material, strokeColor: Color("advertisment"))
                            .onTapGesture {
                                materialSheet.toggle()
                            }
                    }
                    
                    CustomAddFieldNav(hint: "Zustand", text: $condition, strokeColor: Color("advertisment"))
                        .onTapGesture {
                            conditionSheet.toggle()
                        }
                    
                    CustomAddFieldNav(hint: "Versand", text: $shipment, strokeColor: Color("advertisment"))
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
                    
                    CustomAddFieldNav(hint: "Optional", text: $optional, strokeColor: Color("advertisment"))
                        .onTapGesture {
                            optionalSheet.toggle()
                        }
                    
                    PrimaryBtn(title: "Anzeige Speichern", action: updateProduct)
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $categorySheet) {
            CategoryView(category: $category, categorySheet: $categorySheet) {
                categorySelected in
                category = categorySelected
            }
            .presentationDetents([.fraction(0.35)])
        }
        
        .sheet(isPresented: $conditionSheet) {
            ConditionView(condition: $condition, conditionSheet: $conditionSheet) {
                conditionSelected in
                condition = conditionSelected
            }
        }
        
        .sheet(isPresented: $shipmentSheet) {
            ShipmentView(shipment: $shipment, shipmentSheet: $shipmentSheet) {
                shipmentSelected in
                shipment = shipmentSelected
            }
            .presentationDetents([.fraction(0.35)])
        }
        
        .sheet(isPresented: $materialSheet) {
            MaterialView(material: $material, materialSheet: $materialSheet) {
                materialSelected in
                material = materialSelected
            }
            .presentationDetents([.fraction(0.35)])
        }
        
        .sheet(isPresented: $priceTypeSheet) {
            PriceTypeView(priceType: $priceType, priceTypeSheet: $priceTypeSheet) {
                priceTypeSelected in
                priceType = priceTypeSelected
            }
            .presentationDetents([.fraction(0.35)])
        }
        
        .sheet(isPresented: $optionalSheet) {
            OptionsView(option: $optional, optionSheet: $optionalSheet) {
                optionalSelected in
                optional = optionalSelected
            }
        }
        .onAppear{
            title = product.title
            category = product.category
            condition = product.condition
            shipment = product.shipment
            optional = product.optional ?? ""
            description = product.description
            material = product.material ?? ""
            priceType = product.priceType
            price = product.price
            imageURL = product.imageURL ?? ""
            
        }
        .onChange(of: productViewModel.selectedImage) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    if let compressedData = UIImage(data: data)?.jpegData(compressionQuality: 0.5) {
                        productViewModel.selectedImageData = compressedData
                    } else {
                        print("Bildkomprimierung fehlgeschlagen")
                    }
                }
            }
        }
    }
    
    func updateProduct() {
        
        let currentProduct = product
        
        let updatedProduct = FireProduct(
            id: currentProduct.id, 
            userId: currentProduct.userId,
            title: title,
            category: category,
            condition: condition,
            shipment: shipment,
            optional: optional,
            description: description,
            advertismentType: currentProduct.advertismentType,
            material: material,
            price: price,
            priceType: priceType,
            startAdvertisment: currentProduct.startAdvertisment,
            imageURL: imageURL
        )
        
        if updatedProduct != currentProduct {
            
            productViewModel.updateProductDetails(id: product.id!, product: updatedProduct)
        }
    }
}

#Preview {
    ProductEditView(
        product: FireProduct(
            userId: "1", title: "Einkaufstascheasdasdad", category: "Videospiel", condition: "VB", shipment: "Nur Abholung",
            description: "blabla", advertismentType: "Ich biete", price: "20", priceType: "VB",
            startAdvertisment: Date.now,
            imageURL:
                "https://arkadiuspielka.files.wordpress.com/2024/02/71qmz4m-yjl.jpg"
        ))
    .environmentObject(ProductViewModel())
}
