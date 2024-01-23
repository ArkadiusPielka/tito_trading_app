//
//  AddressAutoCompleteViewModel.swift
//  TiTo
//
//  Created by Arkadius Pielka on 23.01.24.
//

import Foundation

class AddressAutoCompleteViewModel: ObservableObject {
    
    init() {
        fetchAddress()
    }
    
    @Published var address: [AddressDetails] = []
    @Published var addressSearch = ""
    
    
    func fetchAddress() {
        Task {
            do {
                self.address = try await AddressAutoCompletem.fetchAddress(addressSearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            } catch {
                print(error)
            }
        }
    }
}
