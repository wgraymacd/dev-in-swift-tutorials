//
//  Message.swift
//  Alphabetizer
//
//  Created by William MacDonald on 12/13/24.
//

import Foundation

// Alphabetizer has no message: String to use in MessageView, and this is intentional
// Because there are several messages and they’re mutually exclusive, an enum is the ideal data structure
enum Message: String { // Give the enum a String raw value, which associates a String value with each enum case
    case instructions = "Place the tiles in alphabetical order"
    case tryAgain = "Almost 😅"
    case youWin = "You win! 🏆"
}


