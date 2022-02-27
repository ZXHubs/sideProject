//
//  HomeViewController.swift
//  exercise
//
//  Created by ZhangX on 2022/2/27.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI()
        
    }
    

}

// MARK: - 设置UI界面
extension HomeViewController {
    private func setupUI() {
        // 设置导航栏
        setupNavgationBar()
    }
    
    private func setupNavgationBar() {
        // 设置左侧的item
//        let btn = UIButton()
//        btn.setImage(UIImage(systemName: "globe.americas"), for: .normal)
//        btn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "globe.americas")
        
        // 设置右侧item
        let size = CGSize(width: 50, height: 50)
        
        // 构造函数
        let historyItem = UIBarButtonItem(imageName: "clock", highImageName: "clock.fill", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "magnifyingglass.circle", highImageName: "magnifyingglass.circle.fill", size: size)

        let qrcodeItem = UIBarButtonItem(imageName: "qrcode", highImageName: "qrcode.viewfinder", size: size)
        
        /*
        下面是类方法
        let historyItem = UIBarButtonItem.createItem(imageName: "clock", highImageName: "clock.fill", size: size)
        
        let searchItem = UIBarButtonItem.createItem(imageName: "magnifyingglass.circle", highImageName: "magnifyingglass.circle.fill", size: size)

        let qrcodeItem = UIBarButtonItem.createItem(imageName: "qrcode", highImageName: "qrcode.viewfinder", size: size)
         
         */
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}


