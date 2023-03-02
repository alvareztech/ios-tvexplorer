//
//  Show.swift
//  TVExplorer
//
//  Created by Daniel Alvarez on 01/03/23.
//

import Foundation
import SwiftUI

struct ResultItem: Codable {
    var show: Show
}

struct Show: Codable {
    var id: Int
    var url: String
    var name: String
    var status: String?
    var image: Image?
    var summary: String?
    var rating: Rating?
    
    struct Rating: Codable {
        var average: Double?
    }
    
    struct Image: Codable {
        var medium: String
        var original: String
    }
    
    enum CodingKeys: CodingKey {
        case id, url, name, status, image, summary, rating
    }
    
    var ratingValue: String {
        guard let rating = rating?.average else { return "" }
        return String(rating)
    }
    
    var bannerURL: URL? {
        URL(string: image?.medium ?? "")
    }
    
    var statusColor: Color {
        if status?.lowercased() == "ended" {
            return Color.red
        }
        return Color.gray
    }
}

struct Alias: Codable {
    var name: String
    var country: Country?
    
    struct Country: Codable {
        var name: String
        var code: String
        var timezone: String
    }
}
