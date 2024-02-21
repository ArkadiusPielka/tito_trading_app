//
//  CountryView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 23.01.24.
//

import SwiftUI

struct CountryView: View {
    
    @Binding var country: String
    @Binding var countrySheet: Bool
    var selectedcountry: (String) -> Void
    
    var body: some View {
        VStack {
            Text("Land")
                .padding(.vertical, CGFloat.sheetTitleVertical)
            
            List(Country.allCases, id: \.self) { country in
                Button(action: {
                    selectedcountry(country.title)
                    countrySheet = false
                }) {
                    VStack(alignment: .leading) {
                        Text(country.title)
                            .foregroundColor(.primary)
                            .font(.title2)
                            .padding(.bottom, 8)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    CountryView(country: .constant(""), countrySheet: .constant(false), selectedcountry: {_ in})
}
