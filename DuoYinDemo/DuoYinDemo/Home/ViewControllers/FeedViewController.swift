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
import Lottie

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
    
    private lazy var avatarButton: FeedUserAvatarView = {
            return FeedUserAvatarView(user: self.feed.author ?? FeedModel.Author(id: "0", name: "未知"))
        }()

    private lazy var likeButton: FeedLikeButton =  {
            let button = FeedLikeButton(frame: .zero)
            return button
        }()

    private lazy var commentButton: UIButton =  {
            let button = UIButton()
            button.setImage(UIImage(named: "icon_home_comment40x40"), for: .normal)
            return button
        }()

    private lazy var shareButton: UIButton =  {
            let button = UIButton()
            button.setImage(UIImage(named: "iconHomeShareRight40x40"), for: .normal)
            return button
        }()

    private lazy var rightButtonsStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.alignment = .center
            stackView.distribution = .equalCentering
            stackView.axis = .vertical
            stackView.spacing = 10
            return stackView
        }()
    
    private lazy var pauseImageView: UIImageView = {
        let imageView = UIImageView(image:UIImage(named: "icon_feed_white_pause72x72"))
        imageView.contentMode = .scaleAspectFit
        return imageView
        
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
        
        view.addSubview(rightButtonsStackView)
        
        rightButtonsStackView.addArrangedSubview(avatarButton)
        rightButtonsStackView.addArrangedSubview(likeButton)
        rightButtonsStackView.addArrangedSubview(commentButton)
        rightButtonsStackView.addArrangedSubview(shareButton)
        
        rightButtonsStackView.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.bottom.equalTo(self.view.snp.bottom).offset(-200)
            make.trailing.equalTo(self.view.snp.trailing).offset(-10)
        }
        
        view.addSubview(pauseImageView)
        
        pauseImageView.snp.makeConstraints { make in
            make.center.equalTo(self.view.center)
        }
        
        pauseImageView.isHidden = true
        
        // 思考 1 点击屏幕暂停播放、继续播放 双击点赞
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(gesture:)))
        singleTapGesture.numberOfTapsRequired = 1
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(gesture:)))
        doubleTapGesture.numberOfTapsRequired = 2
        
        singleTapGesture.require(toFail: doubleTapGesture)
        
        view.addGestureRecognizer(singleTapGesture)
        view.addGestureRecognizer(doubleTapGesture)
        
        // 2 player loop 循环播放
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { [weak self]_ in
            self?.player?.seek(to: .zero)
            self?.player?.play()
        }
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
    
    @objc func handleSingleTap(gesture: UITapGestureRecognizer) {
        guard let player = player else {
            return
        }
        if player.rate > 0 {
            pause()
            pauseImageView.isHidden = false
        } else {
            play()
            pauseImageView.isHidden = true
        }
    }
    
    @objc func handleDoubleTap(gesture: UITapGestureRecognizer) {
        
        let animationView = AnimationView(name: "icon_home_like_new")
        
        let location = gesture.location(in: view)
        let size = CGSize(width: 80, height: 80)
        let origin = CGPoint(x: location.x-size.width/2, y: location.y-size.height/2)
        animationView.frame = CGRect(origin: origin, size: size)
        
        view.addSubview(animationView)
        animationView.play(completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800)) {
            animationView.removeFromSuperview()
        }
        
        NotificationCenter.default.post(name: .init(rawValue: "didTapLikeNotification"), object: nil)
    }
}
