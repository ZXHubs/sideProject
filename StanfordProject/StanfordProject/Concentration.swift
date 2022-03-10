//
//  Concentration.swift
//  StanfordProject
//
//  Created by ZhangX on 2022/3/10.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index:Int) {
        if !cards[index].isMatched {
            if let matchIdex = indexOfOneAndOnlyFaceUpCard, matchIdex != index {
                // check if cards match
                if cards[matchIdex].identifier == cards[index].identifier {
                    cards[matchIdex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceup = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceup = false
                }
                cards[index].isFaceup = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
    }
}
