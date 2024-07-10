//
//  ImagePlayerViewController.swift
//  iPods
//
//  Created by admin on 2024/1/6.
//

import UIKit
open class ImagePlayerViewController:UIViewController{
    public var datas:[IMediaItem] = []
    public var index:Int = 0
    open override func loadView() {
        view = contentView
    }
    
    lazy var closeBtn: UIButton = {
        let value = UIButton(frame: .init(origin: .zero, size: .init(width: 32, height: 32)))
        value.i_radius = 4
        value.backgroundColor = .systemGroupedBackground
        value.setTitleColor(.black, for: .normal)
        value.setImage(.init(systemName: "chevron.left"), for: .normal)
        value.tintColor = .tertiaryLabel
        value.addTarget(self, action: #selector(dismissvc), for: .touchUpInside)
        return value
    }()
    
    lazy var shareBtn: UIButton = {
        let value = UIButton(frame: .init(origin: .zero, size: .init(width: 32, height: 32)))
        value.i_radius = 4
        value.backgroundColor = .systemGroupedBackground
        value.setTitleColor(.black, for: .normal)
        value.setImage(.init(systemName: "square.and.arrow.up"), for: .normal)
        value.tintColor = .tertiaryLabel
        value.addTarget(self, action: #selector(shareBtnClick), for: .touchUpInside)
        return value
    }()
    
    @objc func dismissvc(){
        self.dismiss(animated: true)
    }

    lazy var contentView: ImagePlayerView = {
        let value = ImagePlayerView.init(datas: datas,index: index)
        value.longPressBlock = {cell in
            guard let indexPath = self.contentView.collectionView.indexPath(for: cell) else {return}
            self.shareIndexPath(indexPath: indexPath)
        }
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
        view.backgroundColor = .black
    }
    
    func makeUI(){
        view.addSubview(closeBtn)
        view.addSubview(shareBtn)
    }
    
    func makeLayout(){
     
        closeBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.size.equalTo(32)
        }
        shareBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-12)
            make.size.equalTo(32)
        }

    }
    @objc
    func shareBtnClick(){
        guard let cell = contentView.collectionView.visibleCells.first,
              let indexpath = contentView.collectionView.indexPath(for: cell) else{
            view.tost(msg: "无分享内容")
            return
        }
        self.shareIndexPath(indexPath: indexpath)
    }
    func shareIndexPath(indexPath:IndexPath){
        let mediaItem = self.datas[indexPath.section]
        var shareItems:[Any] = []
        if let image = mediaItem.image{
            shareItems.append(image)
        }
        if shareItems.count<=0{
            view.tost(msg: "无分享内容")
            return
        }
        self.share(shareItems)
    }
    func share(_ contends:[Any]){
      
        // 创建 UIActivityViewController
        let activityViewController = UIActivityViewController(activityItems:contends, applicationActivities: nil)

        // Setting要排除的分享选项
//        activityViewController.excludedActivityTypes = [.addToReadingList, .airDrop, .assignToContact]

        // 显示 UIActivityViewController
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.contentView
            popoverController.sourceRect = self.view.bounds
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
}

