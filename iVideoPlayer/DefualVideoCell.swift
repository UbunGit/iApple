//
//  DefualVideoCell.swift
//  iApple
//
//  Created by mac on 2023/4/20.
//

import UIKit
import AVFoundation
import SJVideoPlayer
open class DefualVideoCell: UICollectionViewCell {
    class PlaybackController:SJAVMediaPlaybackController{
        
    }
  
//    public lazy var player: SJVideoPlayer = {
//        let player = SJVideoPlayer()
//        player.autoplayWhenSetNewAsset = false
//        player.playbackController = PlaybackController()
//
//        return player
//    }()
    @objc  public lazy var thumbnailImgiew: UIImageView = {
        let value = UIImageView()
        value.isUserInteractionEnabled = true
        return value
    }()
   
     
     public override init(frame: CGRect) {
      
         super.init(frame: frame)
         makeUI()
         makeLayout()
//         DispatchQueue.main.asyncAfter(deadline: .now()+0.35){
//             self.player.view.frame = self.videoContainerView.bounds
//         }
     }
     
     required public init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     open func makeUI(){
         contentView.addSubview(thumbnailImgiew)

         
     }
     open func makeLayout(){
         thumbnailImgiew.snp.makeConstraints { make in
             make.edges.equalToSuperview()
         }
     
     }
     open override func prepareForReuse() {
         super.prepareForReuse()
      
         debugPrint(tag)
      
     }
}
