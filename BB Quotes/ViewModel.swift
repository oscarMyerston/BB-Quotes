//
//  ViewModel.swift
//  BB Quotes
//
//  Created by Oscar David Myerston Vega on 22/02/23.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    
    enum Status {
        case notStarted
        case fetching
        case success(data: (Quote, Character))
        case failed(error: Error)
    }
    
    @Published private(set) var status: Status = .notStarted
    private let controller: FetchController
    
    init(controller: FetchController) {
        self.controller = controller
    }
    
    func getData(from show: String) async {
        status = .fetching
        
        do {
            var quote = try await controller.fetchQuote()
            
            while quote.series != show {
                quote = try await controller.fetchQuote()
            }
            
            var characterName = quote.author
            
            if quote.author == "Gus Fring" {
                characterName = "Gustavo Fring"
            } else if quote.author == "Hank Schrader" {
                characterName = "Henry Schrander"
            } else if quote.author == "Jimmy McGill" {
                characterName = "Saul Goodman"
            } else if quote.author == "Kim Wexler" {
                characterName = "Kimberly Wexler"
            } else if quote.author == "Chuck McGill" {
                characterName = "Charles McGill"
            }
            let character = try await controller.fetchCharacter(name: characterName)
            status = .success(data: (quote, character))
        } catch {
            status = .failed(error: error)
        }
    }
}
