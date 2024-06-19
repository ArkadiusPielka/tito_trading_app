//
//  OptionalOptionsView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 15.01.24.
//

import SwiftUI

struct OptionsView: View {
    
    @Binding var option: String
    @Binding var optionSheet: Bool
    var selectedOption: (String) -> Void
    
    var body: some View {
        VStack {
            Text("Optionen")
                .font(.title2)
                .padding(.vertical, CGFloat.sheetTitleVertical)
                .padding(.top)

            List(Options.allCases, id: \.self) { option in
                Button(action: {
                    selectedOption(option.title)
                    optionSheet = false
                }) {
                    VStack(alignment: .leading) {
                        Text(option.title)
                            .foregroundColor(.primary)
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 8)
                        Text(option.subTitle)
                            .foregroundColor(Color("subText"))
                    }
                }
            }
        }
        
    }
}

#Preview {
    OptionsView(option: .constant(""), optionSheet: .constant(false), selectedOption: {_ in})
}
