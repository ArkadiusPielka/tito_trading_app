//
//  UserDetailView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 22.01.24.
//

import SwiftUI
import PhotosUI

struct UserDetailView: View {

  @EnvironmentObject var userAuthViewModel: UserAuthViewModel
  @EnvironmentObject var photosPicker: PhotosPickerViewModel

  @Binding var showDetails: Bool

  @State var street = ""
  @State var plz = ""
  @State var city = ""

  var body: some View {
      
    VStack {
        
      if showDetails {
        HStack {
          Spacer()
          TextBtn(title: "Acount löschen", action: deleteAccount)
            .frame(maxWidth: 150)
            .accentColor(.red)
            .padding(.bottom, 24)
        }
      }
        
      HStack(alignment: .center, spacing: 16) {
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 111, height: 111)
          .background(
            Group {
              if let imageData = photosPicker.selectedImage {

                Image(uiImage: imageData)
                  .resizable()
              } else {

                Image(systemName: "person")
                  .resizable()
              }
            }
          )
          .cornerRadius(111)

        VStack(alignment: .leading, spacing: 6) {
            
          Text(userAuthViewModel.user?.kontoType ?? "privat")
          Text(userAuthViewModel.user?.name ?? "akki")
            .font(.title2)
            .bold()
            
          Group {
            Text("angemeldet am:")
            Text(formattedDate)
          }
          .foregroundColor(Color("subText"))
        }
        .padding(.vertical, 8)
        .frame(width: 186, alignment: .leading)
        .cornerRadius(20)
      }
        
      if showDetails {
          VStack(alignment: .leading, spacing: 16) {
            PhotosPicker(selection: $photosPicker.imageSelection, matching: .images, preferredItemEncoding: .automatic) {
                
                Image(systemName: "camera.fill")
                    .resizable()
                    .frame(width: 40, height: 30)
                Text("Profilbild ändern")
            }
            .padding(.top)
              
          CustomAddField(hint: "Straße", text: $street, strokeColor: Color("profil"))

          HStack {
            CustomAddField(hint: "PLZ", text: $plz, strokeColor: Color("profil"))
              .keyboardType(.numberPad)
              .frame(width: /*@START_MENU_TOKEN@*/ 100 /*@END_MENU_TOKEN@*/)
            CustomAddField(hint: "Stadt", text: $city, strokeColor: Color("profil"))
          }
          PrimaryBtn(title: "Profil speichern", action: updateProfile)
            .accentColor(Color("profil"))
        }
      }
    }

    .padding(16)
    .frame(width: 360, alignment: .center)
    .cornerRadius(20)
    .overlay(
      RoundedRectangle(cornerRadius: 20)
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
    showDetails.toggle()
    //TODO: func
  }

  func deleteAccount() {

  }
}

#Preview{
  UserDetailView(showDetails: .constant(true))
    .environmentObject(UserAuthViewModel())
    .environmentObject(PhotosPickerViewModel())
}
