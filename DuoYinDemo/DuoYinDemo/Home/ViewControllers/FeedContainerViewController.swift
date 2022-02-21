//
//  FeedContainerViewController.swift
//  DuoYinDemo
//
//  Created by ZhangX on 2022/2/17.
//

import UIKit
import SnapKit

// ContainerVC 服务的协议，并非展示视图，而是管理试图
protocol FeedContainerViewControllnerDelegate: NSObjectProtocol {
    
    func feedContainerViewController(controller: FeedContainerViewController, viewControllerAt indexPath:IndexPath) -> UIViewController // 返回对应位置的控制器
    
    func numberOfViewControllers(in containerViewController:FeedContainerViewController) -> Int // 返回控制器个数
    func feedContainerViewController(controller: FeedContainerViewController, didScroll scrollView: UIScrollView)
}


class FeedContainerViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    // 加上weak避免循环引用
    public weak var delegate: FeedContainerViewControllnerDelegate?
    
    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        collection view layout
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        
//        collection view
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedContainerCollectionViewCell.self, forCellWithReuseIdentifier: FeedContainerCollectionViewCell.reuseIdentifierString)
        collectionView.isPagingEnabled = true //允许分页
        collectionView.showsHorizontalScrollIndicator = false
        
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return false
    }
    
    // MARK: Public
    public func setPageIndex(index: Int, animated: Bool) {
        guard index < collectionView.numberOfItems(inSection: 0) else {
            return
        }
        collectionView.setContentOffset(CGPoint(x: CGFloat(index)*collectionView.frame.width, y: 0), animated: animated)
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.feedContainerViewController(controller: self, didScroll: scrollView)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? FeedContainerCollectionViewCell else {
            return
        }
        cell.viewController?.beginAppearanceTransition(true, animated: false)
        cell.viewController?.endAppearanceTransition()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? FeedContainerCollectionViewCell else {
            return
        }
        cell.viewController?.beginAppearanceTransition(false, animated: false)
        cell.viewController?.endAppearanceTransition()
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.numberOfViewControllers(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedContainerCollectionViewCell.reuseIdentifierString, for: indexPath)as!FeedContainerCollectionViewCell
        if let viewController = delegate?.feedContainerViewController(controller: self, viewControllerAt: indexPath){
            cell.config(with: viewController)
        }
        cell.backgroundColor = UIColor.randomColor // 颜色随机
        return cell
    }


}
