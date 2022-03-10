//
//  ViewController.swift
//  StanfordProject
//
//  Created by ZhangX on 2022/3/5.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (buttons.count + 1) / 2)
    
    var flipCount: Int = 0 {
        didSet {
            scoreLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = buttons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }

    func updateViewFromModel() {
        for index in buttons.indices {
            let button = buttons[index]
            let card = game.cards[index]
            
            if card.isFaceup {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? UIColor.gray : UIColor.orange
            }
        }
    }
    var emoji: Array<String> = ["🎃", "👻", "🎃", "👻"]
    var emoj = Dictionary<Int,String>()
    
    func emoji(for card: Card) ->String {
        if emoj[card.identifier] == nil,
            emoji.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emoji.count)))
            emoj[card.identifier] = emoji.remove(at: randomIndex)
        }
        return emoj[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.textColor = .orange
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.systemFont(ofSize: 30)
        
    }


}

