//
//  VideoListViewController.swift
//  iApple
//
//  Created by mac on 2023/3/23.
//

import UIKit
import FDFullscreenPopGesture
import AVFoundation

open class VideoListViewController<T:Any>: UIViewController,I_UITableViewProtocol {
    open var items: [T] = []
    public let player = AVPlayer()
    public lazy var tableView: UITableView = {
        let value = UITableView.init(frame: .zero,style: .plain)
        value.dataSource = self
        value.delegate = self
        value.contentInsetAdjustmentBehavior = .never
        value.i_registerCell(DefualCell.self)
        value.isPagingEnabled = true
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden  = true
        
        makeUI()
        makeLayout()
        
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func makeUI(){
        view.addSubview(tableView)
    }
    
    func makeLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("需要子类实现tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)")
        
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.height
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate{
            return
        }
        reSetPlayer()
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        reSetPlayer()
    }
    open func reSetPlayer(){
        //        let offset = tableView.contentOffset
        //        let bound = tableView.bounds.size
        //        let point = CGPoint(x: offset.x+bound.width/2, y: offset.y+bound.height/2)
        //        if let indexpath = tableView.indexPathForRow(at: point),
        //        let cell = tableView.cellForRow(at: indexpath){
        //            cell.playerLayer.player = player
        //            let celldata = items[indexpath.row]
        //            let item = AVPlayerItem.init(url: <#T##URL#>)
        //        }else{
        //
        //        }
        
        
    }
    
}



extension VideoListViewController{
    
    open class DefualCell:UITableViewCell{
        
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
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        func makeUI(){
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

