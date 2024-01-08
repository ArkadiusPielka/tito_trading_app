//
//  Extetions.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

extension View {
    var safeArea: UIEdgeInsets {
        if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets {
            return safeArea
        }
        
        return .zero
    }
}


extension View {
    func glow(for tab: Tab, activeTab: Tab, radius: CGFloat) -> some View {
        self
            .shadow(color: tab == activeTab ? tab.color : .clear, radius: radius / 2.5)
            .shadow(color: tab == activeTab ? tab.color : .clear, radius: radius / 2.5)
            .shadow(color: tab == activeTab ? tab.color : .clear, radius: radius / 2.5)
    }

}
