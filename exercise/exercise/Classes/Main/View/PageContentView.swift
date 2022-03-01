//
//  PageContentView.swift
//  exercise
//
//  Created by ZhangX on 2022/3/1.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView, UICollectionViewDataSource {

    // MARK: 定义属性
    private var childVC: [UIViewController]
    private var parentsViewController: UIViewController
    
    // MARK: 懒加载属性
    private lazy var collectionView: UICollectionView = {
       // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionView.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    // MARK: 自定义构造函数
    init(frame: CGRect, childVC: [UIViewController], parentsViewController: UIViewController) {
        self.childVC = childVC
        self.parentsViewController = parentsViewController
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVC.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2.给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childVC[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

// MARK: 设置UI界面
extension PageContentView {
    private func setupUI() {
        // 1.将所有的子控制器添加到父控制器中
        for childVCs in childVC {
            parentsViewController.addChild(childVCs)
        }
        
        // 2.添加UICollectionView，用于在cell中存放控制器view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

