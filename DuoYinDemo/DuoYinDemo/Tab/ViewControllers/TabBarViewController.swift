//
//  TabBarViewController.swift
//  DuoYinDemo
//
//  Created by ZhangX on 2022/2/17.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        // 首页
        let feedRootVC = FeedRootViewController()
        addChildViewController(childViewController: feedRootVC, title: "首页", image: nil, selectedIamge: nil)
        
        // 朋友
        let friendRootVC = FriendRootViewController()
        addChildViewController(childViewController: friendRootVC, title: "朋友", image: nil, selectedIamge: nil)
        
        // 相机
        let cameraRootVC = CameraRootViewController()
        let addImage = UIImage(named: "icon_home_add")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) // 需要此方法保持最初样式
        addChildViewController(childViewController: cameraRootVC, title: nil, image: addImage, selectedIamge: addImage)
        
        // 消息
        let messageRootVC = MessageRootViewController()
        addChildViewController(childViewController: messageRootVC, title: "消息", image: nil, selectedIamge: nil)
        
        // 我
        let profileRootVC = ProfileRootViewController()
        addChildViewController(childViewController: profileRootVC, title: "我", image: nil, selectedIamge: nil)
        
    }
    
    // MARK: private
    private func addChildViewController(childViewController: UIViewController,
                                        title: String?,
                                        image: UIImage? = nil,
                                        selectedIamge: UIImage? = nil) {
        let navigationController = UINavigationController(rootViewController: childViewController)
        // 隐藏导航栏
        navigationController.setNavigationBarHidden(true, animated: false)
        
        let tabBarItem = navigationController.tabBarItem
        tabBarItem?.title = title
        tabBarItem?.image = image
        tabBarItem?.selectedImage = selectedIamge
        
        if let _ = title {
            // 标题
            tabBarItem?.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: UIColor.red,
                                    .font: UIFont.systemFont(ofSize: 15)],
                    for: UIControl.State.normal)
            tabBarItem?.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: UIColor.blue,
                                    .font: UIFont.systemFont(ofSize: 15)],
                    for: UIControl.State.selected)
            tabBarItem?.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -15)
        } else {
            // 图片
            tabBarItem?.imageInsets = UIEdgeInsets(top: 5.5, left: 0, bottom: -5.5, right: 0)
        }
        // 添加子控制器
        addChild(navigationController)
    }

}
