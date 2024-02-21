//
//  RecommendedRepository.swift
//  TiTo
//
//  Created by Arkadius Pielka on 10.01.24.
//

import Foundation

class RecommendedRepository {
    
    static func fetchRecommended() async throws -> [Recommended] {
        
        guard let url = URL(string: "https://retoolapi.dev/wjXbW4/tito") else {
            throw HTTPError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode([Recommended].self, from: data)
            return response
        } catch {
            print("Fehler beim Decodieren der Daten: \(error)")
            throw error
        }
    }
}
