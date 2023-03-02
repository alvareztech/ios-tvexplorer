//
//  TVService.swift
//  TVExplorer
//
//  Created by Daniel Alvarez on 01/03/23.
//

import Foundation

let kApi = "api.tvmaze.com"
let kShowsEndpoint = "/search/shows"
let kAliasEndpoint = "/shows/%@/akas"

enum NetworkError: Error {
    case badURL
    case someError
}

class NetworkService {
    
    func fetchShows(query: String) async throws -> [ResultItem] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = kApi
        components.path = kShowsEndpoint
        components.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]
        guard let url = components.url else { throw NetworkError.badURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try? JSONDecoder().decode([ResultItem].self, from: data)
        return response ?? []
    }
    
    func fetchAliases(showId: Int) async throws -> [Alias] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = kApi
        components.path = kAliasEndpoint.replacingOccurrences(of: "%@", with: String(showId))
        guard let url = components.url else { throw NetworkError.badURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try? JSONDecoder().decode([Alias].self, from: data)
        return response ?? []
    }
}
