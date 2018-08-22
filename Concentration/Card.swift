//
//  Card.swift
//  Concentration
//
//  Created by Victor Li on 8/17/18.
//  Copyright © 2018 Victor Li. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var emoji: String
    
    private var identifier: Int
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(emoji: String) {
        self.identifier = Card.getUniqueIdentifier()
        self.emoji = emoji
    }
}
