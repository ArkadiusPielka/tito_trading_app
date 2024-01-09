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
        VStack {
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
                    Text(userAuthViewModel.user?.name ?? "")
                    Text(formattedDate)
                }
                .padding(.horizontal, 16)
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
            
            PrimaryBtn(title: "Abmelden", action: logOut)
        }
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: userAuthViewModel.user?.registeredAt ?? Date())
    }
    
    func logOut() {
        userAuthViewModel.logOut()
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserAuthViewModel())
}
