//
//  UIViewController+Douyin.swift
//  DuoYinDemo
//
//  Created by ZhangX on 2022/2/17.
//

// 通常做对类做扩展的时候，会采取类名+扩展名

import Foundation
import UIKit

extension UIViewController {
    // 此方法是为当前控制器添加子控制器，添加好之后还有布局的闭包
    func addChild(childViewController: UIViewController?, layout:(_ view: UIView)->Void) {
        guard let childViewController = childViewController else {
            return
        }
        view.addSubview(childViewController.view)
        /*
         调用自身提供的addChild，设置视图控制器的父子关系，最好调用didmove通知子vc以及加到了
         父vc上
         */
        addChild(childViewController)
        childViewController.didMove(toParent: self)
        
        layout(childViewController.view)
        
    }
}
