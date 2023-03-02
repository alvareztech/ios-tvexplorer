//
//  String+Markdown.swift
//  TVExplorer
//
//  Created by Daniel Alvarez on 01/03/23.
//

import Foundation

extension String {
    
    /// Super basic HTML to Markdown converter
    var markdown: String {
        self.replacingOccurrences(of: "<p>", with: "\n")
            .replacingOccurrences(of: "</p>", with: "\n")
            .replacingOccurrences(of: "<b>", with: "**")
            .replacingOccurrences(of: "</b>", with: "**")
            .replacingOccurrences(of: "<i>", with: "*")
            .replacingOccurrences(of: "</i>", with: "*")
    }
    
    var toAttributed: AttributedString {
        do {
            return try AttributedString(markdown: self)
        } catch {
            return AttributedString("Error parsing markdown: \(error)")
        }
    }
}
