//
//  FeedTableViewCell.swift
//  DuoYinDemo
//
//  Created by ZhangX on 2022/2/20.
//

import Foundation
import UIKit

class FeedTableViewCell: UITableViewCell {
    
    static let reuseIdentifierString = "FeedTableViewCell"
    
    var viewController: FeedViewController?
    
    func config(_ feed: FeedModel) {
        viewController?.view.removeFromSuperview()
        let vc = FeedViewController(with: feed)
        viewController = vc
        contentView.addSubview(vc.view)
        vc.view.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    func play() {
        viewController?.play()
    }
    
    func pause() {
        viewController?.pause()
    }
    
}
