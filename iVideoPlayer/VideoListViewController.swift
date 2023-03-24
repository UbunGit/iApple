//
//  VideoListViewController.swift
//  iApple
//
//  Created by mac on 2023/3/23.
//

import UIKit
import FDFullscreenPopGesture
import AVFoundation

open class VideoListViewController<T:Any>: UIViewController,I_UICollectionViewProtocol {
    
    open var items: [T] = []
    public let player = AVPlayer()
    lazy var backBrn: UIButton = {
        let value = UIButton()
        value.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        value.backgroundColor = .secondarySystemGroupedBackground
        value.tintColor = .white
        value.i_radius = 8
        value.setBlockFor(.touchUpInside) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        return value
    }()
   
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let value = UICollectionView(frame: .zero, collectionViewLayout: layout)
        value.dataSource = self
        value.delegate = self
        value.contentInsetAdjustmentBehavior = .never
        value.i_register(cellType: DefualCell.self)
        value.isPagingEnabled = true
        return value
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden  = true
        makeUI()
        makeLayout()
        
    }
 
    func makeUI(){
        view.addSubview(collectionView)
        view.addSubview(backBrn)
    }
    
    func makeLayout(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backBrn.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.top.equalToSuperview().offset(UIScreen.i_safeAreaInsets.top+20)
            make.left.equalToSuperview().offset(UIScreen.i_safeAreaInsets.left+20)
        }
    }
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("需要子类实现collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell")
    }
   
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
   
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate{
            return
        }
        reSetPlayer()
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        reSetPlayer()
    }
    open func reSetPlayer(){
   
        
        
    }
    
}



extension VideoListViewController{
    
    open class DefualCell:UICollectionViewCell{
        
       public lazy var playerLayer: AVPlayerLayer = {
            let playerLayer = AVPlayerLayer()
            return playerLayer
        }()
        
        public lazy var thumbnailImgiew: UIImageView = {
            let value = UIImageView()
            return value
        }()
        public lazy var videoContainerView: UIView = {
            let value = UIView()
            return value
        }()
        
        public override init(frame: CGRect) {
         
            super.init(frame: frame)
            makeUI()
            makeLayout()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.35){
                self.playerLayer.frame = self.videoContainerView.bounds
                self.videoContainerView.layer.addSublayer(self.playerLayer)
            }
        }
        
        required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        open func makeUI(){
            contentView.addSubview(thumbnailImgiew)
            contentView.addSubview(videoContainerView)
            
        }
        open func makeLayout(){
            thumbnailImgiew.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            videoContainerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        open override func prepareForReuse() {
            super.prepareForReuse()
            debugPrint(tag)
            thumbnailImgiew.image = nil
            playerLayer.player = nil
          
        }
        
        
    }
}

