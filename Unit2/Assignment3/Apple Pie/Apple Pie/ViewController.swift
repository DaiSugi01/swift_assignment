//
//  ViewController.swift
//  Apple Pie
//
//  Created by 杉原大貴 on 2020/12/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var playerTurnLabel: UILabel!
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet var player1PointLabel: UILabel!
    @IBOutlet var player1ScoreLabel: UILabel!
    @IBOutlet var player2PointLabel: UILabel!
    @IBOutlet var player2ScoreLabel: UILabel!
    
    var player1: Player = Player()
    var player2: Player = Player()
    
    var listOfWords = ["abc", "abc", "buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7
    var gameRound = 1 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    var point: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        setupLayout()
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false

        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        
        if currentGame.isPplayerGuessedCorrect(letter: letter) {
            currentGame.playerTurn ? player1.getPoint() : player2.getPoint()
        } else {
            currentGame.changePlayer()
        }
        setupLayout()
        updateGameState()
    }
    
    func setupLayout() {
        if currentGame.playerTurn {
            playerTurnLabel.text = "Round: \(gameRound), Player 1 Turn"
        } else {
            playerTurnLabel.text = "Round: \(gameRound), Player 2 Turn"
        }
    }
        
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemainning: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButton(true)
            updateUI()
        } else {
            enableLetterButton(false)
        }
    }

    func enableLetterButton(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }

    func updateUI() {
        let letters: [String] = currentGame.formattedWord.map{ String($0) }
        let wordWithSpacing = letters.joined(separator: " ")
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemainning)")
        correctWordLabel.text = wordWithSpacing
        player1PointLabel.text = "Player1 Score: \((player1.point))"
        player1ScoreLabel.text = "Wins: \(player1.totalWins), Losses: \(player1.totalLosses)"
        player2PointLabel.text = "Player2 Score: \(player2.point)"
        player2ScoreLabel.text = "Wins: \(player2.totalWins), Losses: \(player2.totalLosses)"
    }

    func updateGameState() {
        if currentGame.playerTurn {
            if currentGame.incorrectMovesRemainning == 0 {
                player1.lose()
                player2.won()
                gameRound += 1
            } else if currentGame.word == currentGame.formattedWord {
                player1.won()
                player2.lose()
                gameRound += 1
            } else {
                updateUI()
            }
        } else {
            if currentGame.incorrectMovesRemainning == 0 {
                player1.won()
                player2.lose()
                gameRound += 1
            } else if currentGame.word == currentGame.formattedWord {
                player1.lose()
                player2.won()
                gameRound += 1
            } else {
                updateUI()
            }

        }
    }
    
}

