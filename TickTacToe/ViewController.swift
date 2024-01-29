//
//  ViewController.swift
//  TickTacToe
//
//  Created by Karina ❦ on 29.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case Nought
        case Cross
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var nought = "♡"
    var cross = "X"
    var board = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(nought) {
            resultAlert(title: "Нолики победили!")
        }
        
        if checkForVictory(cross) {
            resultAlert(title: "Крестики победили!")
        }
        
        if (fullBoard()) {
            resultAlert(title: "Ничья!")
        }
    }
    
    @IBAction func resetButton(_ sender: Any) {
        resetAlert()
    }
    
    private func checkForVictory(_ symbol: String) -> Bool {
        // Horizontal victory
        if thisSymbol(a1, symbol) && thisSymbol(a2, symbol) && thisSymbol(a3, symbol) {
            return true
        }
        
        if thisSymbol(b1, symbol) && thisSymbol(b2, symbol) && thisSymbol(b3, symbol) {
            return true
        }
        
        if thisSymbol(c1, symbol) && thisSymbol(c2, symbol) && thisSymbol(c3, symbol) {
            return true
        }
        
        // Vertical victory
        if thisSymbol(a1, symbol) && thisSymbol(b1, symbol) && thisSymbol(c1, symbol) {
            return true
        }
        
        if thisSymbol(a2, symbol) && thisSymbol(b2, symbol) && thisSymbol(c2, symbol) {
            return true
        }
        
        if thisSymbol(a3, symbol) && thisSymbol(b3, symbol) && thisSymbol(c3, symbol) {
            return true
        }
        
        // Diagonal victory
        if thisSymbol(a1, symbol) && thisSymbol(b2, symbol) && thisSymbol(c3, symbol) {
            return true
        }
        
        if thisSymbol(a3, symbol) && thisSymbol(b2, symbol) && thisSymbol(c1, symbol) {
            return true
        }
        
        return false
    }
    
    private func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    private func resultAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Новая игра", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        
        self.present(alert, animated: true)
    }
    
    private func resetAlert() {
        let alert = UIAlertController(title: "Начать заново?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { (_) in
            self.resetBoard()
        }))
        
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel))
        
        self.present(alert, animated: true)
    }
    
    private func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        if firstTurn == Turn.Cross {
            firstTurn = Turn.Nought
            turnLabel.text = nought
        }
        
        else if firstTurn == Turn.Nought {
            firstTurn = Turn.Cross
            turnLabel.text = cross
        }
        
        currentTurn = firstTurn
    }
    
    private func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    
    private func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    private func addToBoard(_ sender: UIButton) {
        if sender.title(for: .normal) == nil {
            if currentTurn == Turn.Nought {
                sender.setTitle(nought, for: .normal)
                sender.setTitleColor(.angelPink, for: .normal)
                
                currentTurn = Turn.Cross
                turnLabel.text = cross
                turnLabel.textColor = .chocolate
            }
            else if currentTurn == Turn.Cross {
                sender.setTitle(cross, for: .normal)
                sender.setTitleColor(.chocolate, for: .normal)
                
                currentTurn = Turn.Nought
                turnLabel.text = nought
                turnLabel.textColor = .angelPink
            }
            
            sender.isEnabled = false
        }
    }
}

