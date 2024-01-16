//
//  ProfileView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center, spacing: 16) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 111, height: 111)
                    .background(
                        Image("bild2")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 111, height: 111)
                            .clipped()
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
//                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(width: 186, alignment: .leading)
                .cornerRadius(20)
            }
            .padding(16)
            .frame(width: 360, alignment: .center)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 0.5)
                    .stroke(Color("profil"))
            )
            
            PrimaryBtn(title: "Profil bearbeiten", action: logOut)
                .accentColor(Color("profil"))
            
            
            PrimaryBtn(title: "Abmelden", action: logOut)
            Spacer()
            PrimaryBtn(title: "Löschen", action: deleteUser)
                .accentColor(.red)
            
            
        }
        .padding(.horizontal)
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        //        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: userAuthViewModel.user?.registeredAt ?? Date())
    }
    
    func logOut() {
        userAuthViewModel.logOut()
    }
    
    func deleteUser() {
        userAuthViewModel.deleteUser()
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserAuthViewModel())
}
