//
//  ViewController.swift
//  StanfordProject
//
//  Created by ZhangX on 2022/3/5.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func touchCard(_ sender: UIButton) {
        filpCard(withEmoji: "🥳", on: sender)
    }
    
    @IBAction func secondCard(_ sender: UIButton) {
        filpCard(withEmoji: "🤣", on: sender)
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
        // Do any additional setup after loading the view.
    }


}

