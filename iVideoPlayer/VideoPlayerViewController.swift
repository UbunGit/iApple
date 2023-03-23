//
//  VideoPlayerViewController.swift
//  Alamofire
//
//  Created by mac on 2023/3/23.
//

import UIKit
import AVFoundation



open class VideoPlayerViewController: UIViewController {
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    public var videoURL: URL!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加背景图片
        let backgroundImage = UIImageView(frame: view.bounds)
        backgroundImage.image = UIImage(named: "background_image")
        view.addSubview(backgroundImage)
        
        // 创建播放器
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        view.layer.addSublayer(playerLayer)
        
        // 添加播放/暂停按钮
        let playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        playButton.center = view.center
        playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        view.addSubview(playButton)
        
        // 监听播放结束
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    // 播放/暂停按钮点击事件
    @objc func playButtonTapped() {
        if player.rate == 0 {
            player.play()
        } else {
            player.pause()
        }
    }
    
    // 播放结束事件
    @objc func playerDidFinishPlaying() {
        player.seek(to: CMTime.zero)
    }
    
    // 界面旋转时调整视频播放区域
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        playerLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.width * 9 / 16)
    }
    
    
}
