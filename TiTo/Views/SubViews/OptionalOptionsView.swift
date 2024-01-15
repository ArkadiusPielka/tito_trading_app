//
//  OptionalOptionsView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 15.01.24.
//

import SwiftUI

struct OptionalOptionsView: View {
    
    @Binding var option: String
    @Binding var optionSheet: Bool
    var selectedOption: (String) -> Void
    
    var body: some View {
        VStack {
            Text("Optionen")
            
            List(OptionalOptions.allCases, id: \.self) { option in
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
    OptionalOptionsView(option: .constant(""), optionSheet: .constant(false), selectedOption: {_ in})
}
