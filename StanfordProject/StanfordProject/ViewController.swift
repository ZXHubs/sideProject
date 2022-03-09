//
//  ViewController.swift
//  StanfordProject
//
//  Created by ZhangX on 2022/3/5.
//

import UIKit

class ViewController: UIViewController {
    
    var flipCount: Int = 0 {
        didSet {
            scoreLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emoji: Array<String> = ["🎃", "👻", "🎃", "👻"]
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = buttons.firstIndex(of: sender){
            filpCard(withEmoji: emoji[cardNumber], on: sender)
        }
    }

    func filpCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = UIColor.white
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = UIColor.orange
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.textColor = .orange
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.systemFont(ofSize: 30)
        
    }


}

