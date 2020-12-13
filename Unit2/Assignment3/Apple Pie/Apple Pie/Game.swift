//
//  Game.swift
//  Apple Pie
//
//  Created by 杉原大貴 on 2020/12/11.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemainning: Int
    var guessedLetters: [Character]
    var playerTurn: Bool = true
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        print(guessedWord)
        return guessedWord
    }
    
    mutating func guessedByWord(inputWord: String) -> Bool {
        if inputWord != word {
            incorrectMovesRemainning -= 1
            return false
        }
        return true
    }
    
    mutating func isPplayerGuessedCorrect(letter: Character) -> Bool {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemainning -= 1
            return false
        }

        return true        
    }
    
    mutating func changePlayer() {
        playerTurn = !playerTurn
    }
}
