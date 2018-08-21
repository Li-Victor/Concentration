//
//  Card.swift
//  Concentration
//
//  Created by Victor Li on 8/17/18.
//  Copyright © 2018 Victor Li. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var emoji: String
    
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
