//
//  ScoreKeeperTests.swift
//  ScoreKeeperTests
//
//  Created by William MacDonald on 12/12/24.
//

import Testing

@testable import ScoreKeeper

struct ScoreKeeperTests {
    // @Test annotation marks this function as a test method
    // async and throws indicate that your method could use the concurrency or error-handling features of Swift
    @Test("Reset Player Scores", arguments: [0, 10, 20])  // these arguments are all sent to the test method (3 separate calls)
    func resetScores(to newValue: Int) async throws {
        var scoreboard = Scoreboard(players: [
            Player(name: "Elisha", score: 0),
            Player(name: "Andre", score: 5),
        ])
        scoreboard.resetScores(to: newValue)

        for player in scoreboard.players {
            #expect(player.score == newValue)
        }
    }

    @Test("Highest Score Wins")
    func highestScoreWins() {
        let scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 5),
            ],
            state: .gameOver,
            doesHighestScoreWin: true
        )
        
        let winners = scoreboard.winners
        
        #expect(winners == [Player(name: "Andre", score: 5)])
    }
    
    @Test("Lowest Score Wins")
    func lowestScoreWins() {
        let scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 5),
            ],
            state: .gameOver,
            doesHighestScoreWin: false
        )
        
        let winners = scoreboard.winners
        
        #expect(winners == [Player(name: "Elisha", score: 0)])
    }

}
