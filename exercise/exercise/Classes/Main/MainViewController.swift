//
//  MainViewController.swift
//  exercise
//
//  Created by ZhangX on 2022/2/27.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
        
    }
    
    private func addChildVC(storyName: String) {
        
        // 1.通过 storyboard 获取控制器
        let childVC = UIStoryboard(name: storyName , bundle: nil).instantiateInitialViewController()!
        
        // 2.将childVC作为子控制器
        addChild(childVC)
    }

   

}
