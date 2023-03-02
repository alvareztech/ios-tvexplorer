//
//  ShowViewModel.swift
//  TVExplorer
//
//  Created by Daniel Alvarez on 01/03/23.
//

import Foundation

@MainActor
class ShowsViewModel: ObservableObject {
    @Published var shows: [ResultItem] = []
    @Published var currentShowAliases: String = ""
    @Published var searchText: String = ""
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func loadShows() async {
        do {
            shows = try await networkService.fetchShows(query: searchText)
        } catch {}
    }
    
    func loadAlias(showId: Int) async {
        do {
            let alias = try await networkService.fetchAliases(showId: showId)
            currentShowAliases = alias.map { $0.name }.joined(separator: ", ")
        } catch {}
    }
}
