//
//  Concentration.swift
//  Concentration
//
//  Created by Victor Li on 8/17/18.
//  Copyright © 2018 Victor Li. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    
    private(set) var flipCount = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func incrementFlipCount() {
        flipCount = flipCount + 1
    }
    
    mutating func resetFlipCount() {
        flipCount = 0
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards)")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    private mutating func shuffle() {
        for i in stride(from: cards.count - 1, to: 1, by: -1) {
            let random = i.arc4random
            self.cards.swapAt(i, random)
        }
    }

    init(numberOfPairsOfCards: Int, emojis: [String]) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards\(numberOfPairsOfCards)): you must have at least one pair of cards")
        assert(numberOfPairsOfCards < emojis.count, "Concentration.init(numberOfPairsOfCards: \(numberOfPairsOfCards), emojis: \(emojis)): you must have the same or more pairs of cards than emojis")
        
        var e = emojis
        for _ in 0..<numberOfPairsOfCards {
            let emoji = e.remove(at: e.count.arc4random)
            let card = Card(emoji: emoji)
            cards += [card, card]
        }
        shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
