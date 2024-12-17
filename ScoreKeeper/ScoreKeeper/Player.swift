//
//  Player.swift
//  ScoreKeeper
//
//  Created by William MacDonald on 12/11/24.
//

import Foundation

// create your own data type
struct Player: Identifiable { // Identifiable is a protocol: defines a blueprint of methods, properties, and other requirements for a type
    let id = UUID() // universally unique ID, need to add id so that Player conforms with Identifiable protocol
    
    // declare with var so they can be changed while in use
    var name: String
    var score: Int
}

// When you declare that a type conforms to Equatable, Swift automatically provides an implementation that compares all properties of the type and returns true if they’re equal, not what you want for Player, Players with the same name and score should be equal, even if they have different IDs
// Because id has a different value for each instance, it’s more useful to check the other properties to determine equality
extension Player: Equatable {
    // define the == operator
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.name == rhs.name && lhs.score == rhs.score
    }
}
