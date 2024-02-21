//
//  NavigationView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct NavigationView: View {
    
    @State var activTab: Tab = .home
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            activTab.getMainView()
            
            Spacer()
            
            CustomTabBar(activTab: $activTab)
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Rectangle().fill(.clear).ignoresSafeArea())
        .preferredColorScheme(isDarkMode ? .dark : .light)
        
    }
}

#Preview {
    NavigationView()
        .environmentObject(UserAuthViewModel())
        .environmentObject(ProductViewModel())
        .environmentObject(MessagesViewModel())
    
}
