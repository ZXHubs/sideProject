//
//  Card.swift
//  StanfordProject
//
//  Created by ZhangX on 2022/3/10.
//

import Foundation


// struct 没有继承，值类型，类是引用
struct Card {
    var isFaceup = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueidentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueidentifier()
    }
}
