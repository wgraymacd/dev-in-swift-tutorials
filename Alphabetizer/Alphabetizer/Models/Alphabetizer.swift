//
//  Alphabetizer.swift
//  Alphabetizer
//
//  Created by William MacDonald on 12/13/24.
//

import Foundation

// classes have a built-in identity
// Alphabetizer is a class instead of a struct because the views that will share the Alphabetizer all need to use the same instance – the same "brain"
// the brain of the app belongs in the Models folder
@Observable // adds new functionality to a class, changes to observable properties drive SwiftUI view updates
class Alphabetizer {
    private let tileCount = 3
    private var vocab: Vocabulary
    
    var tiles = [Tile]()
    var score = 0
    var message: Message = .instructions
    
    // using ocean animals as default, making testing easier
    init(vocab: Vocabulary = .landAnimals) {
        self.vocab = vocab
        startNewGame()
    }
    
    
    /// Checks if tiles are in alphabetical order
    func submit() {
        // check if the tiles are alphabetized
        let userSortedTiles = tiles.sorted {
            // shorthand syntax for omitting parameter names and the in keyword - $0 refers to the first or only parameter in a closure and $1 refers to the second parameter - may want to avoid this if having `first, second in` is more clear
            $0.position.x < $1.position.x
        }
        let alphabeticallySortedTiles = tiles.sorted {
            $0.word.lexicographicallyPrecedes($1.word)
        }
        let isAlphabetized = userSortedTiles == alphabeticallySortedTiles
        
        // if alphabetized, increment the score
        if isAlphabetized {
            score += 1
        }
        
        
        // update the message to win or lose
        message = isAlphabetized ? .youWin : .tryAgain
        
        
        // flip over correct tiles
        for (tile, correctTile) in zip(userSortedTiles, alphabeticallySortedTiles) {
            let tileIsAlphabetized = tile == correctTile
            tile.flipped = tileIsAlphabetized
        }
        
        
        // Task runs asynchronous code
        // When writing concurrent code, you must ensure that all UI updates go through the main actor
        // Because changes to the Alphabetizer class’s properties drive UI changes (through @Observable), you make all updates to those properties on the main actor
        Task { @MainActor in
            // Delay 2 seconds
            try await Task.sleep(for: .seconds(2)) // await keyword goes before asynchronous functions, which are functions that can be paused
            
            // If alphabetized, generate new tiles
            if isAlphabetized {
                startNewGame()
            }
            
            // Flip tiles back to words
            for tile in tiles {
                tile.flipped = false // OK if flipped is already false. If the value doesn’t change, SwiftUI won’t render unnecessary updates
            }
            
            // Display instructions
            message = .instructions
        }
        
        
    }
    
    // these thick comments (labeled with something like TODO or MARK) show up in the jump bar
    // MARK: private implementation
    
    /// Updates `tiles` with a new set of unalphabetized words
    private func startNewGame() {
        let newWords = vocab.selectRandomWords(count: tileCount)
        if tiles.isEmpty {
            for word in newWords {
                tiles.append(Tile(word: word))
            }
        } else {
            // Assign new words to existing tiles
            // There are two arrays, but for loops only operate on one array at a time, so use zip to pair up tiles and words
            for (tile, word) in zip(tiles, newWords) {
                tile.word = word
            }
        }
    }
}
