//
//  RecommendenViewModel.swift
//  TiTo
//
//  Created by Arkadius Pielka on 10.01.24.
//

import Foundation

@MainActor
class RecommendedViewModel: ObservableObject {
    
    
    init() {
        fetchData()
    }
    
    @Published var article: [Recommended] = []

    
    
    func fetchData() {
        Task {
            do {
                self.article = try await RecommendedRepository.fetchRecommended()
            } catch {
                print(error)
            }
        }
    }
}
