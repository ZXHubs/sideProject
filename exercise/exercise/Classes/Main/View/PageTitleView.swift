//
//  PageTitleView.swift
//  exercise
//
//  Created by ZhangX on 2022/2/27.
//

import UIKit

private let scrollLineHeigh: CGFloat = 2

class PageTitleView: UIView {

    // MARK: 定义属性
    private var titles: [String]
    
    // MARK: 懒加载属性
    private lazy var titleLabels: [UILabel] = [UILabel]()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false //做状态栏点击回到顶部，需要将其他这个属性为false
//        scrollView.isPagingEnabled = false 默认是false
        scrollView.bounces = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK: 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: 设置UI界面
extension PageTitleView {
    private func setupUI() {
        // 1.添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加title对应的Label
        setupTitleLabels()
        
        // 3.设置底线和滚动滑块
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels() {
        
        // 0. 确定label一些frame的值
        let labelWidth: CGFloat = frame.width / CGFloat(titles.count)
        let labelHeigh: CGFloat = frame.height - scrollLineHeigh
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            // 1.创建UILabel
            let label = UILabel()
            
            // 2.设置Label属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            // 3.设置Label的frame
            let labelX: CGFloat = labelWidth * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeigh)
            
            // 4.将Label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        // 1.添加底线
        let bottomLine = UIView()
        let lineHeigh: CGFloat = 0.5
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineHeigh, width: frame.width, height: lineHeigh)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        // 2.1 获取第一个Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        
        // 2.2 设置scrollLine属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - scrollLineHeigh, width: firstLabel.frame.width, height: scrollLineHeigh)
    }
}
