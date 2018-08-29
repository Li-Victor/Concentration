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
    private(set) var score = 0
    
    private var cardsSeen: Set<Card>
    
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
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards)")
        flipCount += 1
        if !cards[index].isMatched {
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                
                // matches so increment score by two
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    self.score += 2
                } else {
                    // mismatched
                    
                    // if the set has the card, decrement by 1
                    // if the set doesnt have the card, add to the set
                    
                    // first
                    if cardsSeen.contains(cards[matchIndex]) {
                        self.score -= 1
                    } else {
                        cardsSeen.insert(cards[matchIndex])
                    }
                    
                    // second
                    if cardsSeen.contains(cards[index]) {
                        self.score -= 1
                    } else {
                        cardsSeen.insert(cards[index])
                    }
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func resetGame() {
        flipCount = 0
        score = 0
    }
    
    private mutating func shuffle() {
        for i in stride(from: cards.count - 1, to: 1, by: -1) {
            let random = i.arc4Random
            self.cards.swapAt(i, random)
        }
    }

    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards\(numberOfPairsOfCards)): you must have at least one pair of cards")
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        self.score = 0
        self.flipCount = 0
        self.cardsSeen = Set<Card>()
        shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
