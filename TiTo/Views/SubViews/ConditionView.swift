//
//  ConditionView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.01.24.
//

import SwiftUI

struct ConditionView: View {
    
    @Binding var condition: String
    @Binding var conditionSheet: Bool
    var selectedCondition: (String) -> Void
    
    var body: some View {
        VStack {
            Text("Zustand")
                .padding()
            
            List(Condition.allCases, id: \.self) { condition in
                Button(action: {
                    selectedCondition(condition.title)
                    conditionSheet = false
                }) {
                    VStack(alignment: .leading) {
                        Text(condition.title)
                            .foregroundColor(.primary)
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 8)
                        Text(condition.subTitle)
                            .foregroundColor(Color("subText"))
                    }
                }
            }
        }
        
    }
}

#Preview {
    ConditionView(condition: .constant("Gur"), conditionSheet: .constant(false), selectedCondition: {_ in })
}
