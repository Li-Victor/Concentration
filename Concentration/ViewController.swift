//
//  ViewController.swift
//  Concentration
//
//  Created by Victor Li on 8/16/18.
//  Copyright © 2018 Victor Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func touchNewGame() {
        // assign game to a new Concentration game
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emoji = [Card:String]()
        emojiChoices = randomEmojiTheme()
        let (CardColor, BackgroundColor) = randomThemeColor()
        cardColor = CardColor
        backgroundColor = BackgroundColor
        updateViewFromModel()
    }
    
    private var cardColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    private var backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : cardColor
            }
        }
        view.backgroundColor = backgroundColor
        
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount) | Score: \(game.score)", attributes: attributes)
        
        flipCountLabel.attributedText = attributedString
    }
    
    private var scaryTheme = ["🎃", "👻", "😱", "😈", "👽", "🙀", "👹", "🤡"]
    private var animalTheme = ["🐶", "🐱", "🦊", "🐸", "🐔", "🐨", "🐧", "🦄"]
    private var sportsTheme = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏓", "🏐", "🎱"]
    private var faceTheme = ["🤔", "😀", "😁", "😍", "😕", "😘", "😛", "😓"]
    private var fruitsTheme = ["🍏", "🍓", "🍆", "🍊", "🍉", "🍋", "🍑", "🍌"]
    private var handSignsTheme = ["🤘", "👌", "👋", "👎", "👍", "✌️", "👊", "🤙"]
    
    func randomEmojiTheme() -> String {
        let allThemes = [scaryTheme, animalTheme, sportsTheme, faceTheme, fruitsTheme, handSignsTheme]
        return allThemes[allThemes.count.arc4Random].joined(separator: "")
    }
    
    private lazy var emojiChoices = randomEmojiTheme()
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
            emoji[card] = String(emojiChoices.remove(at: stringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    private func randomThemeColor() -> (CardColor: UIColor, BackgroundColor: UIColor) {
        
        let colors = [
            (#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
            (#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
            (#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),
            (#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)),
            (#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
            (#colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
            (#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)),
            (#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
            (#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)),
            (#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)),
            (#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)),
            (#colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
        ]
        return colors[colors.count.arc4Random]
    }
    
}

extension Int {
    var arc4Random: Int {
        switch self {
        case 1...Int.max:
            return Int(arc4random_uniform(UInt32(self)))
        case -Int.max..<0:
            return Int(arc4random_uniform(UInt32(self)))
        default:
            return 0
        }
    }
}

