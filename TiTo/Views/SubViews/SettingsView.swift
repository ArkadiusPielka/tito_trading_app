//
//  SettingsView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 21.02.24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @Binding var showSettings: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Toggle("Light/Dark", isOn: $isDarkMode)
                
                
            }
            .toggleStyle(SwitchToggleStyle(tint: .profil))
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: CGFloat.cardCornerRadius)
                    .inset(by: 0.5)
                    .stroke(Color("profil"))
            )
            
            PrimaryBtn(title: "Abmelden", action: logOut)
                .accentColor(Color("favorite"))
                .padding(.top, 34)
            
        }
        .padding()
    }
    
    func logOut() {
        userAuthViewModel.logOut()
        productViewModel.removeListener()
        showSettings.toggle()
    }
}

#Preview {
    SettingsView(showSettings: .constant(false))
        .environmentObject(UserAuthViewModel())
        .environmentObject(ProductViewModel())
}
