//
//  ShipmentView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 12.01.24.
//

import SwiftUI

struct ShipmentView: View {
    
    @Binding var shipment: String
    @Binding var shipmentSheet: Bool
    var selectedShipment: (String) -> Void
    
    var body: some View {
        VStack {
            Text("Versand")
                .font(.title2)
                .padding(.vertical, CGFloat.sheetTitleVertical)
                .padding(.top)
            
            List(Shipment.allCases, id: \.self) { shipment in
                Button(action: {
                    selectedShipment(shipment.title)
                    shipmentSheet = false
                }) {
                    VStack(alignment: .leading) {
                        Text(shipment.title)
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
    ShipmentView(shipment: .constant("ja"), shipmentSheet: .constant(false), selectedShipment: {_ in})
}
