//
//  UserDetailView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 22.01.24.
//

import PhotosUI
import SwiftUI

struct UserDetailView: View {
    
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    
    @Binding var showDetails: Bool
    @State var showCountry = false
    @State var searchAddress = ""
    
    @State var street = ""
    @State var plz = ""
    @State var city = ""
    @State var hausNr = ""
    @State var name = ""
    @State var email = ""
    @State var country = ""
    @State var imageURL = ""
    
    var body: some View {
        VStack {
            
            if showDetails {
                HStack {
                    
                    TextBtn(title: "Acount löschen", action: deleteAccount)
                        .frame(maxWidth: 150)
                        .accentColor(.red)
                    
                    Spacer()
                    
                    Button {
                        showDetails.toggle()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.bottom, 24)
            }
            
            HStack(alignment: .center, spacing: 16) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 111, height: 111)
                    .background(
                        AsyncImage(url: URL(string: userAuthViewModel.user?.imageURL ?? "")) { phase in
                            switch phase {
                            case .empty:
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 111, height: 111)
                            case .success(let image):
                                if let selectedImage = userAuthViewModel.selectedImageData, let image = UIImage(data: selectedImage) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 111, height: 111)
                                } else {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 111, height: 111)
                                }
                            case .failure:
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 111, height: 111)
                                
                            @unknown default:
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 111, height: 111)
                            }
                        }
                    )
                    .cornerRadius(111)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(userAuthViewModel.user?.kontoType ?? "")
                    if showDetails {
                        CustomAddField(hint: "Name", text:  $name, strokeColor: Color("profil"))
                    } else {
                        Text(userAuthViewModel.user?.name ?? "")
                            .font(.title2)
                            .bold()
                    }
                    Group {
                        Text("angemeldet am:")
                        Text(formattedDate)
                    }
                    .foregroundColor(Color("subText"))
                }
                .frame(width: 186, alignment: .leading)
                Spacer()
            }
            
            if showDetails {
                VStack(alignment: .leading, spacing: 16) {
                    PhotosPicker(
                        selection: $userAuthViewModel.selectedImage, matching: .images,
                        preferredItemEncoding: .automatic
                    ) {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .frame(width: 40, height: 30)
                        Text("Profilbild ändern")
                    }
                    
                    .padding(.top)
                    
                    CustomAddField(hint: "E-Mail", text:  $email, strokeColor: Color("profil"))
                    
                    HStack {
                        CustomAddField(hint: "Straße", text:  $street, strokeColor: Color("profil"))
                        CustomAddField(hint: "Nr.", text: $hausNr, strokeColor: Color("profil"))
                            .frame(width: /*@START_MENU_TOKEN@*/ 100 /*@END_MENU_TOKEN@*/)
                    }
                    HStack {
                        CustomAddField(hint: "PLZ", text: $plz, strokeColor: Color("profil"))
                            .keyboardType(.numberPad)
                            .frame(width: /*@START_MENU_TOKEN@*/ 100 /*@END_MENU_TOKEN@*/)
                        CustomAddField(hint: "Stadt", text: $city, strokeColor: Color("profil"))
                    }
                    
                    CustomAddFieldNav(hint: "Land", text: $country, strokeColor: Color("profil"))
                        .onTapGesture {
                            showCountry.toggle()
                        }
                    
                    PrimaryBtn(title: "Profil speichern", action: updateProfile)
                        .accentColor(Color("profil"))
                }
                .onAppear{
                    city = userAuthViewModel.user?.city ?? ""
                    plz = userAuthViewModel.user?.plz ?? ""
                    hausNr = userAuthViewModel.user?.housenumber ?? ""
                    street = userAuthViewModel.user?.street ?? ""
                    email = userAuthViewModel.user?.email ?? ""
                    name = userAuthViewModel.user?.name ?? ""
                    country = userAuthViewModel.user?.country ?? ""
                    imageURL = userAuthViewModel.user?.imageURL ?? ""
                }
                .onChange(of: userAuthViewModel.selectedImage) { _, newItem in
                    //TODO: komprimierte Speicherung
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            if let compressedData = UIImage(data: data)?.jpegData(compressionQuality: 0.5) {
                                userAuthViewModel.selectedImageData = compressedData
                            } else {
                                print("Bildkomprimierung fehlgeschlagen")
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showCountry) {
            CountryView(country: $country, countrySheet: $showCountry) {
                countrySelected in
                country = countrySelected
            }
            .presentationDetents([.fraction(0.35)])
        }
        .padding(16)
        .frame(width: .infinity, alignment: .center)
        .overlay(
            RoundedRectangle(cornerRadius: CGFloat.cardCornerRadius)
                .inset(by: 0.5)
                .stroke(Color("profil"))
        )
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        return dateFormatter.string(from: userAuthViewModel.user?.registeredAt ?? Date())
    }
    
    func updateProfile() {
        
        let currentFirebaseUser = userAuthViewModel.user
        
        let updatedUser = FireUser(
            id: userAuthViewModel.user?.id ?? "",
            name: name,
            email: email,
            registeredAt: userAuthViewModel.user?.registeredAt ?? Date(),
            kontoType: userAuthViewModel.user?.kontoType ?? "",
            plz: plz,
            housenumber: hausNr,
            street: street,
            country: country,
            city: city,
            imageURL: imageURL
        )
        
        if updatedUser.name != currentFirebaseUser?.name ||
            updatedUser.email != currentFirebaseUser?.email ||
            updatedUser.plz != currentFirebaseUser?.plz ||
            updatedUser.housenumber != currentFirebaseUser?.housenumber ||
            updatedUser.street != currentFirebaseUser?.street ||
            updatedUser.country != currentFirebaseUser?.country ||
            updatedUser.imageURL != currentFirebaseUser?.imageURL ||
            updatedUser.city != currentFirebaseUser?.city {
            
            userAuthViewModel.updateUser(user: updatedUser)
        }
        showDetails.toggle()
    }
    
    func deleteAccount() {
        //TODO: func
    }
}

#Preview{
    UserDetailView(showDetails: .constant(true))
        .environmentObject(UserAuthViewModel())
    
}

