//
//  Game.swift
//  HangmanChallenge
//
//  Created by Filip Němeček on 20/03/2019.
//  Copyright © 2019 Filip Němeček. All rights reserved.
//

import Foundation

class HangmanGame {
    
    var wordToGuess: String!
    var currentGuessWord: String!
    var guessedCharacters = Set<Character>()
    
    var wrongGuesses = 0
    
    var delegate: HangmanGameDelegate?  
    
    func startGame(with word: String) {
        wrongGuesses = 0
        guessedCharacters.removeAll()
        wordToGuess = word.uppercased()
        currentGuessWord = String(repeating: "_", count: word.count)
        
        delegate?.hangmanGame(game: self, didUpdateGuessText: currentGuessWord)        
    }
    
    func guessCharacter(_ character: Character) -> Bool {
        
        if wordToGuess.contains(character) {
            
            guessedCharacters.insert(character)
            
            rebuildCurrentGuessWord(with: character)
            
            return true
        } else {
            wrongGuesses += 1
            
            if wrongGuesses == 7 {
                delegate?.hangmanGame(game: self, didEnded: .loss)
            }
            
            return false
        }
    }
    
    private func rebuildCurrentGuessWord(with newCharacter: Character) {
        var newGuessWord = ""
        var missingCharacters = false
        
        for character in wordToGuess {
            if guessedCharacters.contains(character) {
                newGuessWord.append(character)
            } else {
                newGuessWord.append("_")
                missingCharacters = true
            }
        }
        
        currentGuessWord = newGuessWord
        
        delegate?.hangmanGame(game: self, didUpdateGuessText: newGuessWord)
        
        if !missingCharacters {
            delegate?.hangmanGame(game: self, didEnded: .win)
        }
    }
    
}
