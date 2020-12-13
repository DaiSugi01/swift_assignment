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
    @IBOutlet var guessInputField: UITextField!
        
    var player1: Player = Player(name: "Player 1")
    var player2: Player = Player(name: "Player 2")
    var currentGame: Game!

    var listOfWords = ["abc", "abc"]
//    var listOfWords = ["abc", "apple", "buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7
    var gameRound = 1 {
        didSet {
            newRound()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        setupRound()
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false

        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        
        if currentGame.isPplayerGuessedCorrect(letter: letter) {
//            createDialogMessage(messageType: .correct)
            currentGame.playerTurn ? player1.getPoint() : player2.getPoint()
        } else {
            createDialogMessage(messageType: .wrong)
            currentGame.changePlayer()
        }
        setupRound()
        updateGameState(word: currentGame.formattedWord)
    }
    
    @IBAction func guessInputPrimaryActionTriggered(_ sender: UITextField) {
        let inputWord = sender.text!
        if !currentGame.guessedByWord(inputWord: inputWord) {
            createDialogMessage(messageType: .wrong)
        }
        updateGameState(word: inputWord)
        guessInputField.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupRound() {
        if currentGame.playerTurn {
            playerTurnLabel.text = "Round: \(gameRound), \(player1.name) Turn"
        } else {
            playerTurnLabel.text = "Round: \(gameRound), \(player2.name) Turn"
        }
    }
        
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemainning: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButton(true)
        } else {
            enableLetterButton(false)
            guessInputField.isUserInteractionEnabled = false
            createDialogMessage(messageType: .end)
        }
        updateUI()
        setupRound()
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
        player1PointLabel.text = "\(player1.name) Score: \((player1.point))"
        player1ScoreLabel.text = "Wins: \(player1.totalWins), Losses: \(player1.totalLosses)"
        player2PointLabel.text = "\(player2.name) Score: \(player2.point)"
        player2ScoreLabel.text = "Wins: \(player2.totalWins), Losses: \(player2.totalLosses)"
    }

    func updateGameState(word: String) {
        if currentGame.incorrectMovesRemainning == 0 {
            gameRound += 1
            createDialogMessage(messageType: .draw)
            return
        }
        
        if currentGame.playerTurn {
            if word == currentGame.word {
                player1.won()
                player2.lose()
                gameRound += 1
                createDialogMessage(messageType: .win, playerName: player1.name)
            } else {
                updateUI()
            }
        } else {
            if word == currentGame.word {
                player2.won()
                player1.lose()
                gameRound += 1
                createDialogMessage(messageType: .win, playerName: player2.name)
            } else {
                updateUI()
            }
        }
    }
    
    func createDialogMessage(messageType: Message, playerName: String? = nil) {
        let dialogMessage = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        switch messageType {
        case .wrong:
            dialogMessage.title = "Worng word"
            dialogMessage.message = "Woops. It seeme like a wrong word."
            let wrong = UIAlertAction(title: "Next Player", style: .default, handler: nil)
            dialogMessage.addAction(wrong)
        case .correct:
            dialogMessage.title = "Correct"
            dialogMessage.message = "That letter is correct!"
            let correct = UIAlertAction(title: "Continue", style: .default, handler: nil)
            dialogMessage.addAction(correct)
        case .draw:
            dialogMessage.title = "Draw!"
            dialogMessage.message = "It's draw."
            let draw = UIAlertAction(title: "Go to next round", style: .default, handler: nil)
            dialogMessage.addAction(draw)
        case .win:
            dialogMessage.title = "Win!!!"
            if let playerName = playerName {
                dialogMessage.message = "\(playerName) win!"
            }
            let win = UIAlertAction(title: "Go to next round", style: .default, handler: nil)
            dialogMessage.addAction(win)
        case .end:
            dialogMessage.title = "Game over"
            dialogMessage.message = """
                \(player1.name) Score: \((player1.point)), Wins: \(player1.totalWins)
                \(player2.name) Score: \(player2.point), Wins: \(player2.totalWins)
                """
            let end = UIAlertAction(title: "End", style: .default, handler: nil)
            dialogMessage.addAction(end)
        }
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

