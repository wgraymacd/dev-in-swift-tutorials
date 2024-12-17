//
//  GameState.swift
//  ScoreKeeper
//
//  Created by William MacDonald on 12/11/24.
//

import Foundation

// enumerations define a common type for a group of related but mutually exclusive values
// the only values of an enumeration that exist are the ones in its definition (unlike struct, which can have many instances)
// model something that is limited to a few different values
enum GameState {
    case setup
    case playing
    case gameOver
}
