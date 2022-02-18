//
//  FeedTabView.swift
//  DuoYinDemo
//
//  Created by ZhangX on 2022/2/18.
//

import Foundation
import UIKit

protocol FeedTabViewDelegate: NSObjectProtocol {
    func didSelect(item:FeedTabView.Item, in tabView:FeedTabView)
}

class FeedTabView: UIView {
    
    struct Item {
        var index: Int
        var title: String
    }
    
    private var items: [Item] = []
    
    private var buttons: [UIButton] = [UIButton]()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center // 设置布局
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var buttonLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.white
        return line
    }()
    
    private var selectedIndex: Int = 0
    
    public weak var delegate: FeedTabViewDelegate?
    
    init(items: [Item], delegate:FeedTabViewDelegate) {
        // items
        self.items = items
        
        // delegate
        self.delegate = delegate
        
        super.init(frame: CGRect.zero)
        // 此处将传入的数据做映射，映射成一组按钮
        self.buttons = self.items.map({ item in
            return self.createButton(item: item)
        })
        
        self.buttons.forEach { button in
            self.stackView.addArrangedSubview(button)
        }
        addSubview(stackView)
        addSubview(buttonLine)
        backgroundColor = UIColor.orange
        
        updateSelectedIndex(with: 0)
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.frame = bounds
        updateSelectedIndex(with: CGFloat(selectedIndex))
    }
    
    public func updateSelectedIndex(with progress: CGFloat) {
        let buttonWidth = bounds.width / CGFloat(items.count)
        // button line
        var frame: CGRect = CGRect.zero
        frame.size = CGSize(width: 20, height: 4)
        frame.origin.y = bounds.height - frame.size.height
        frame.origin.x = (buttonWidth - frame.width) / 2 + buttonWidth * progress
        buttonLine.frame = frame
        
        selectedIndex = Int(round(progress))
        
        for i in 0..<buttons.count {
            let button = buttons[i]
            button.isSelected=(i == selectedIndex)
        }
    }
    
    private func createButton(item: Item) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(item.title, for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.addTarget(self, action: #selector(didTap(button:)), for: .touchUpInside)
        return button
    }
    
    @objc private func didTap(button: UIButton) {
        guard let index = buttons.firstIndex(of: button), index<items.count else {
            return
        }
        delegate?.didSelect(item: items[index], in: self)
    }
}
