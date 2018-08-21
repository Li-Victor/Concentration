//
//  ViewController.swift
//  Concentration
//
//  Created by Victor Li on 8/16/18.
//  Copyright © 2018 Victor Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var scaryTheme = ["🎃", "👻", "😱", "😈", "👽", "🙀", "👹", "🤡"]
    private var animalTheme = ["🐶", "🐱", "🦊", "🐸", "🐔", "🐨", "🐧", "🦄"]
    private var sportsTheme = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏓", "🏐", "🎱"]
    private var faceTheme = ["🤔", "😀", "😁", "😍", "😕", "😘", "😛", "😓"]
    
    
    func randomTheme() -> [String] {
        let allThemes = [scaryTheme, animalTheme, sportsTheme, faceTheme]
        return allThemes[allThemes.count.arc4random]
    }
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards, emojis: randomTheme())
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func touchNewGame() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards, emojis: randomTheme())
        flipCount = 0
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(card.emoji, for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

