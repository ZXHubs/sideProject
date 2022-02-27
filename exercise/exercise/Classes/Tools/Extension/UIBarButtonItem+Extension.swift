//
//  UIBarButtonItem+Extension.swift
//  exercise
//
//  Created by ZhangX on 2022/2/27.
//

import UIKit

extension UIBarButtonItem {
    
//    class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem {
//        let btn = UIButton()
//
//        btn.setImage(UIImage(systemName: imageName), for: .normal)
//        btn.setImage(UIImage(systemName: highImageName), for: .highlighted)
//
//        btn.frame = CGRect(origin: .zero, size: size)
//
//        return UIBarButtonItem(customView: btn)
//    }
    
    // 利用构造函数的方法更加推荐
    // 构造函数无需返回值
    // 便利构造函数 1.convenience 关键字
    //           2. 必须明确调用一个设计构造函数
    convenience init(imageName: String, highImageName: String = "", size: CGSize = .zero) {
        // 1. 创建按钮
        let btn = UIButton()
        // 进一步抽取给定函数参数的默认值
        // 2. 设置按钮图片
        btn.setImage(UIImage(systemName: imageName), for: .normal)
        
        if highImageName != "" {
            btn.setImage(UIImage(systemName: highImageName), for: .highlighted)
        }
        
        // 3. 设置按钮尺寸
        if size == .zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: .zero, size: size)
        }
        // 4. 创建UIBarButtonItem
        self.init(customView: btn)
    }
}
