//
//  ViewController.swift
//  ticTacToe
//
//  Created by Gurpal Bhoot on 10/29/18.
//  Copyright © 2018 Gurpal Bhoot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // IB-Outlets
    @IBOutlet weak var winningLabel: UILabel!
    @IBOutlet weak var gameBoard: UIStackView!
    
    // Buttons
    @IBOutlet weak var topLeftBtn: UIButton!
    @IBOutlet weak var topMiddleBtn: UIButton!
    @IBOutlet weak var topRightBtn: UIButton!
    @IBOutlet weak var centerLeftBtn: UIButton!
    @IBOutlet weak var centerMiddleBtn: UIButton!
    @IBOutlet weak var centerRightBtn: UIButton!
    @IBOutlet weak var bottomLeftBtn: UIButton!
    @IBOutlet weak var bottomMiddleBtn: UIButton!
    @IBOutlet weak var bottomRightBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    @IBOutlet weak var player1Btn: UIButton!
    @IBOutlet weak var player2Btn: UIButton!
    
    
    // Variables
    var currentPlayer = 0
    var playerColors = [#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)]
    var winningPlayer = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupView()
    }
    
    // Functions
    func setupView() {
        winningLabel.isHidden = true
        resetBtn.isHidden = true
        resetBtn.layer.cornerRadius = 5
        player1Btn.isEnabled = false
        player1Btn.backgroundColor = playerColors[0]
        player1Btn.layer.cornerRadius = 5
        player2Btn.isEnabled = false
        player2Btn.backgroundColor = playerColors[1]
        player2Btn.layer.cornerRadius = 5
    }
    
    func alternatePlayer() {
        if currentPlayer == 0 {
            currentPlayer = 1
        } else {
            currentPlayer = 0
        }
    }
    
    func checkGameStatus() -> Bool{
        // Start at top left and check all winning combinations, button by button
        
        // Three scenarios where current player wins
        if topLeftBtn.backgroundColor == playerColors[currentPlayer] {
            if centerLeftBtn.backgroundColor == playerColors[currentPlayer] {
                if bottomLeftBtn.backgroundColor == playerColors[currentPlayer] {
                    winningPlayer = currentPlayer
                    return true
                }
            }
            if topMiddleBtn.backgroundColor == playerColors[currentPlayer] {
                if topRightBtn.backgroundColor == playerColors[currentPlayer] {
                    winningPlayer = currentPlayer
                    return true
                }
            }
            if centerMiddleBtn.backgroundColor == playerColors[currentPlayer] {
                if bottomRightBtn.backgroundColor == playerColors[currentPlayer] {
                    winningPlayer = currentPlayer
                    return true
                }
            }
        }
        
        // One scenario where current player wins
        if topMiddleBtn.backgroundColor == playerColors[currentPlayer] {
            if centerMiddleBtn.backgroundColor == playerColors[currentPlayer] {
                if bottomMiddleBtn.backgroundColor == playerColors[currentPlayer] {
                    winningPlayer = currentPlayer
                    return true
                }
            }
        }
        
        // Two scenarios where current player wins
        if topRightBtn.backgroundColor == playerColors[currentPlayer] {
            if centerRightBtn.backgroundColor == playerColors[currentPlayer] {
                if bottomRightBtn.backgroundColor == playerColors[currentPlayer] {
                    winningPlayer = currentPlayer
                    return true
                }
            }
            if centerMiddleBtn.backgroundColor == playerColors[currentPlayer] {
                if bottomLeftBtn.backgroundColor == playerColors[currentPlayer] {
                    winningPlayer = currentPlayer
                    return true
                }
            }
        }
        
        // One scenario where current player wins
        if centerLeftBtn.backgroundColor == playerColors[currentPlayer] {
            if centerMiddleBtn.backgroundColor == playerColors[currentPlayer] {
                if centerRightBtn.backgroundColor == playerColors[currentPlayer] {
                    winningPlayer = currentPlayer
                    return true
                }
            }
        }
        
        // One scenario where current player wins
        if bottomLeftBtn.backgroundColor == playerColors[currentPlayer] {
            if bottomMiddleBtn.backgroundColor == playerColors[currentPlayer] {
                if bottomRightBtn.backgroundColor == playerColors[currentPlayer] {
                    winningPlayer = currentPlayer
                    return true
                }
            }
        }
        
        return false
    }
    
    func disableAllButtons() {
        for view in gameBoard.subviews as [UIView] {
            if let stack = view as? UIStackView {
                for underview in stack.subviews as [UIView] {
                    if let button = underview as? UIButton {
                        button.isEnabled = false
                    }
                }
            }
        }
    }
    
    func resetAllButtons() {
        for view in gameBoard.subviews as [UIView] {
            if let stack = view as? UIStackView {
                for underview in stack.subviews as [UIView] {
                    if let button = underview as? UIButton {
                        button.isEnabled = true
                        button.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                    }
                }
            }
        }
    }
    
    func gameOver() {
        winningLabel.text = "Player \(currentPlayer+1) has pulled off the impossible!"
        winningLabel.isHidden = false
        disableAllButtons()
    }
    
    func resetGame() {
        print("Resetting the game")
        currentPlayer = 0
        resetAllButtons()
        winningLabel.isHidden = true
    }
    
    // IB-Actions
    @IBAction func gameButtonPressed(_ sender: Any) {
        resetBtn.isHidden = false

        guard let button = sender as? UIButton else {
            return
        }

        if button.backgroundColor != playerColors[0] && button.backgroundColor != playerColors[1] {
            button.backgroundColor = playerColors[currentPlayer]
            
            // Run game check to see if current player has one
            if checkGameStatus() {
                gameOver()
            }
            
            alternatePlayer()
        }
    }

    @IBAction func resetButtonPressed(_ sender: Any) {
        resetGame()
    }
}

