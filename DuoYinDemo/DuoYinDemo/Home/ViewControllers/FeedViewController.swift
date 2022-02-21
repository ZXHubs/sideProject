//
//  FeedViewController.swift
//  DuoYinDemo
//
//  Created by ZhangX on 2022/2/21.
//

import Foundation
import UIKit
import AVFoundation
import SnapKit

class PlayerView: UIView {
    
    private var playerLayer: AVPlayerLayer
    
    init(player: AVPlayer?) {
        playerLayer = AVPlayerLayer(player: player)
        super.init(frame: .zero)
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame=bounds
    }
}

class FeedViewController: UIViewController {
    
    private var feed: FeedModel
    
    private var player: AVPlayer?
    
    private lazy var playerView: PlayerView = {
        PlayerView(player: self.player)
    }()
    
    init(with feed: FeedModel) {
        self.feed = feed
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // player
        // 真是的情况需要做错误处理，万一播放失败比如弹出toast提示等
        player = AVPlayer(url: feed.videoURL!)
        view.addSubview(playerView)
        
        playerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        // 思考 1 点击屏幕暂停播放、继续播放
        // 2 player loop 循环播放
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pause()
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
}
