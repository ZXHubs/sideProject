//
//  FeedRootViewController.swift
//  DuoYinDemo
//
//  Created by ZhangX on 2022/2/17.
//

import UIKit

class FeedRootViewController: UIViewController, FeedContainerViewControllnerDelegate, FeedTabViewDelegate {
    

    private var containerVC: FeedContainerViewController!
    
    private var tabView: FeedTabView!
    
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
        
        // TabView
        tabView = FeedTabView(items: [.init(index: 0, title: "推荐"), .init(index: 1, title: "关注")], delegate: self)
        view.addSubview(tabView)
        tabView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
    
    // MARK: FeedContainerViewControllnerDelegate
    
    func feedContainerViewController(controller: FeedContainerViewController, viewControllerAt indexPath: IndexPath) -> UIViewController {
        let vc = FeedTableViewController()
//        vc.view.backgroundColor = UIColor.randomColor
        return vc
    }
    
    func numberOfViewControllers(in containerViewController: FeedContainerViewController) -> Int {
        return 2
    }
    
    func feedContainerViewController(controller: FeedContainerViewController, didScroll scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width // 一页有多宽
        let contentOffsetX = scrollView.contentOffset.x // 滚动位置
        
        guard pageWidth>0 else {
            return
        }
        let progress = contentOffsetX / pageWidth
        
        tabView.updateSelectedIndex(with: progress)
    }
    
    // MARK: FeedTabViewDelegate
    func didSelect(item: FeedTabView.Item, in tabView: FeedTabView) {
        containerVC.setPageIndex(index: item.index, animated: true)
    }

}
