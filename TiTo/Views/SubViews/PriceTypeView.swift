//
//  PriceTypeView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 15.01.24.
//

import SwiftUI

struct PriceTypeView: View {
    
    @Binding var priceType: String
    @Binding var priceTypeSheet: Bool
    var selectedPriceType: (String) -> Void
    
    var body: some View {
        VStack {
            Text("Preistyp")
                .padding(.vertical, CGFloat.sheetTitleVertical)
            
            List(PriceType.allCases, id: \.self) { priceType in
                Button(action: {
                    selectedPriceType(priceType.title)
                    priceTypeSheet = false
                }) {
                    VStack(alignment: .leading) {
                        Text(priceType.title)
                            .foregroundColor(.primary)
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 8)
                        Text(priceType.subTitle)
                            .foregroundColor(Color("subText"))
                    }
                }
            }
        }
    }
}

#Preview {
    PriceTypeView(priceType: .constant(""), priceTypeSheet: .constant(false), selectedPriceType: {_ in})
}
