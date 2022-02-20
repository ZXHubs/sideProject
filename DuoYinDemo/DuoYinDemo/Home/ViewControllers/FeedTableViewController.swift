//
//  FeedTableViewController.swift
//  DuoYinDemo
//
//  Created by ZhangX on 2022/2/20.
//

import Foundation
import UIKit
import AVFAudio

class FeedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isPagingEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.allowsSelection = false // 是否可以支持选中
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.reuseIdentifierString)
        
        view.addSubview(tableView)
        
        // 设置 audio session
        let session = AVAudioSession.sharedInstance()
        try?session.setCategory(AVAudioSession.Category.playback, options:
                                    AVAudioSession.CategoryOptions.defaultToSpeaker)
        // 处理前后台播放
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: OperationQueue.main) { [weak self]_ in
            self?.pause()
        }
        // 前台播放，后台暂停
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: OperationQueue.main) { [weak self]_ in
            self?.play()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pause()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func play() {
        
    }
    
    private func pause() {
        
    }
    // 自己管理生命周期
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return false
    }
    
    // MARK: UITableViewDelegate
    // 获取每一行高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 做类型转换，判断是否是自定义cell
        guard let cell = cell as? FeedTableViewCell else {
            return
        }
        //                               第一个true，是视图将被加到父视图上
        cell.viewController?.beginAppearanceTransition(true, animated: false)
        
        cell.viewController?.endAppearanceTransition()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 做类型转换，判断是否是自定义cell
        guard let cell = cell as? FeedTableViewCell else {
            return
        }
        //                               第一个true，是视图将被加到父视图上
        cell.viewController?.beginAppearanceTransition(false, animated: false)
        
        cell.viewController?.endAppearanceTransition()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifierString, for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor
        return cell
    }
}
