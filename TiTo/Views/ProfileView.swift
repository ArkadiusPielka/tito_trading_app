//
//  ProfileView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct ProfileView: View {

  @EnvironmentObject var userAuthViewModel: UserAuthViewModel
  @EnvironmentObject var productViewModel: ProductViewModel

  @State var showDetails = false

  var body: some View {
      NavigationStack {
          ScrollView {
              VStack(spacing: 16) {
                  Group {
                      UserDetailView(showDetails: $showDetails)
                          .animation(
                              .easeInOut(duration: 2)
                                  .delay(1),
                              value: 2
                          )
                      
                      PrimaryBtn(title: "Profil bearbeiten", action: userDetails)
                          .accentColor(Color("profil"))
                      
                      PrimaryBtn(title: "Abmelden", action: logOut)
                  }
                  .padding(.horizontal)
                  
                  LazyVStack(spacing: 16) {
                     
                          ForEach(productViewModel.userProducts) { product in
                              ProductCardWithSwipe(product: product)
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

}

#Preview{
  ProfileView()
    .environmentObject(UserAuthViewModel())
    .environmentObject(ProductViewModel())
}
