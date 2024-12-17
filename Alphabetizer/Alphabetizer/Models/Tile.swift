//
//  Tile.swift
//  Alphabetizer
//
//
//

import Foundation

@Observable // Tile uses @Observable to trigger SwiftUI updates when properties change
class Tile: Identifiable {
    let id = UUID()

    var word: String
    var position: CGPoint = .zero
    
    // When flipped, show a checkmark instead of the word and icon
    var flipped = false

    init(word: String) {
        self.word = word
    }

    var icon: String {
        Vocabulary.icons[word] ?? "🤷" // If there is no emoji, fall back to the person shrugging emoji
    }
}

extension Tile: Equatable {
    static func == (lhs: Tile, rhs: Tile) -> Bool {
        lhs.id == rhs.id
    }
}
