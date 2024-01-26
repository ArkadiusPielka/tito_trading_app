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
      NavigationStack {
          ScrollView {
              VStack(spacing: 16) {
                  Group {
                      UserDetailView(showDetails: $showDetails)
                      
                      PrimaryBtn(title: "Profil bearbeiten", action: userDetails)
                          .accentColor(Color("profil"))
                      
                      PrimaryBtn(title: "Abmelden", action: logOut)
                  }
                  .padding(.horizontal)
                  
                  VStack(spacing: 16) {
                      
                      ForEach(productViewModel.userProducts, id: \.id) { product in
                          ProductCard(produkt: product)
                              .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                  Button {
                                      
                                  } label: {
                                      Image(systemName: "trash")
                                  }
                                  .tint(.red)
                              }
                      }
                      
                  }
                  .padding(.horizontal)
                  
              }
              .onAppear{
                  productViewModel.fetchProdukt()
              }
              Spacer(minLength: 20)
          }
    }
    
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
      productViewModel.removeListener()
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
