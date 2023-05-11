//
//  VideoListViewController.swift
//  iApple
//
//  Created by mac on 2023/3/23.
//

import UIKit
import FDFullscreenPopGesture
import AVFoundation
import SJVideoPlayer
public protocol VideoModelProtocol{
    var url:String { get set }
}
open class VideoListViewController<T:VideoModelProtocol>: UIViewController,SJPlayerAutoplayDelegate {
    
    open var dataSouce: [T] = []
  
    public var player = SJVideoPlayer()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        let value = UICollectionView(frame: .zero, collectionViewLayout: layout)
        value.i_register(cellType: DefualVideoCell.self)
        // 开启滑动自动播放
        let config = SJPlayerAutoplayConfig.init(playerSuperviewSelector: NSSelectorFromString("thumbnailImgiew"), autoplayDelegate: self)
        value.sj_enableAutoplay(with: config)
        value.backgroundColor = .clear
        return value
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
        player.controlLayerNeedAppear()
    }
  
 
    open func makeUI(){
        view.addSubview(collectionView)

    }
    
    open func makeLayout(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
       
    }
  
    
// MARK: SJPlayerAutoplayDelegate
    open func sj_playerNeedPlayNewAsset(at indexPath: IndexPath) {
        let celldata = dataSouce[indexPath.row]
        guard let playUrl = URL.init(string: celldata.url) else {return}
        let playModen:SJPlayModel = .init(collectionView: collectionView, indexPath: indexPath,superviewSelector: NSSelectorFromString("thumbnailImgiew"))
        player.urlAsset = .init(url: playUrl,
                                playModel: playModen)
                                
        
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




