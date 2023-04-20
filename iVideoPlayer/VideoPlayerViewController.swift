//
//  VideoPlayerViewController.swift
//  Alamofire
//
//  Created by mac on 2023/3/23.
//

import UIKit
import AVFoundation
import SJVideoPlayer



open class VideoPlayerViewController: UIViewController {
    
    var player = SJVideoPlayer()

    
    public var videoURL: URL!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
        self.makeUI()
        self.makeLayout()
        player.urlAsset = .init(url: self.videoURL)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.35){
            self.player.rotate(.landscapeLeft, animated: true) { player in  
            }
        }
    
    }
    func makeUI(){
        view.addSubview(player.view)
    }
    func makeLayout(){
        player.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.vc_viewDidAppear()

    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.vc_viewWillDisappear()
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.vc_viewDidDisappear()
    }
    open override var prefersHomeIndicatorAutoHidden: Bool{
        return true
    }
    open override var shouldAutorotate: Bool{
        return false
    }
  
    
   

    
    
}
