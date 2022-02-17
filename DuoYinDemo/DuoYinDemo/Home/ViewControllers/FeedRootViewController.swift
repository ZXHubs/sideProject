//
//  FeedRootViewController.swift
//  DuoYinDemo
//
//  Created by ZhangX on 2022/2/17.
//

import UIKit

class FeedRootViewController: UIViewController, FeedContainerViewControllnerDelegate {

    private var containerVC: FeedContainerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化 container VC
        containerVC = FeedContainerViewController()
        containerVC.delegate = self
        addChild(childViewController: containerVC) { subView in
            subView.snp.makeConstraints { make in
                make.leading.trailing.top.equalTo(self.view)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
            }
        }
        
    }
    
    // MARK: FeedContainerViewControllnerDelegate
    
    func feedContainerViewController(controller: FeedContainerViewController, viewControllerAt indexPath: IndexPath) -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.randomColor
        return vc
    }
    
    func numberOfViewControllers(in containerViewController: FeedContainerViewController) -> Int {
        return 2
    }


}
