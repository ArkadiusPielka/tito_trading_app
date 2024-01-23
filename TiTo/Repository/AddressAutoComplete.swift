//
//  AddressAutoComplete.swift
//  TiTo
//
//  Created by Arkadius Pielka on 23.01.24.
//

import Foundation

class AddressAutoCompletem {
    
    static func fetchAddress(_ input: String) async throws -> [AddressDetails] {
        
       let apiKey = "695cc05bfacc4f55a827cc35c6ae7c7c"
        
        
        guard let url = URL(string: "https://api.geoapify.com/v1/geocode/autocomplete?text=\(input)&format=json&apiKey=\(apiKey)") else {
            throw HTTPError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode([AddressDetails].self, from: data)
            return response
        } catch {
            print("Fehler beim Decodieren der Daten: \(error)")
            throw error
        }
    }
}
