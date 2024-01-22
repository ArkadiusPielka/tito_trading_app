//
//  ProfileView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct ProfileView: View {

  @EnvironmentObject var userAuthViewModel: UserAuthViewModel
  @EnvironmentObject var productViewModel: ProduktViewModel
  @EnvironmentObject var photosPicker: PhotosPickerViewModel

  @State var showDetails = false

  var body: some View {
    ScrollView {
      VStack(spacing: 16) {

        UserDetailView(showDetails: $showDetails)

        PrimaryBtn(title: "Profil bearbeiten", action: userDetails)
          .accentColor(Color("profil"))

        PrimaryBtn(title: "Abmelden", action: logOut)

        VStack(spacing: 16) {

          ForEach(productViewModel.userProducts, id: \.id) { product in
            ProductCard(produkt: product)
          }
        }
      }
      Spacer(minLength: 20)
    }
    .padding(.horizontal)
  }

  var formattedDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short

    return dateFormatter.string(from: userAuthViewModel.user?.registeredAt ?? Date())
  }

  func userDetails() {
    showDetails.toggle()
  }

  func logOut() {
    userAuthViewModel.logOut()
  }

  func deleteUser() {
    userAuthViewModel.deleteUser()
  }
}

#Preview{
  ProfileView()
    .environmentObject(UserAuthViewModel())
    .environmentObject(ProduktViewModel())
    .environmentObject(PhotosPickerViewModel())
}
