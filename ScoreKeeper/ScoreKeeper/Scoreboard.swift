//
//  Scoreboard.swift
//  ScoreKeeper
//
//  Created by William MacDonald on 12/11/24.
//

import Foundation

// control all app logic so that unit tests can be run on it
// no UI code
struct Scoreboard {
    var players: [Player] = [
        Player(name: "Elisha", score: 0),
        Player(name: "Andre", score: 0),
        Player(name: "Jasmine", score: 0),
    ]
    
    var state: GameState = GameState.setup // could also write `var state = GameState.setup` or `var state: GameState = .setup`
    var doesHighestScoreWin: Bool = true
    
    var winners: [Player] {
        guard state == .gameOver else { return [] } // guard ensures condition is met, otherwise function exits early
        
        var winningScore = 0
        if doesHighestScoreWin {
            winningScore = Int.min
            for player in players {
                winningScore = max(player.score, winningScore)
            }
        } else {
            winningScore = Int.max
            for player in players {
                winningScore = min(player.score, winningScore)
            }
        }
        
        return players.filter { player in
            player.score == winningScore
        }
    }
    
    // for struct types, you mark any methods that might change the properties of that struct with the mutating keyword
    mutating func resetScores(to newValue: Int) {
        for index in 0..<players.count {
            players[index].score = newValue
        }
    }
}
