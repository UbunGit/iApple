//
//  TrendsPublishViewController.swift
//  Trends
//
//  Created by mac on 2023/7/18.
//

import UIKit
import IQKeyboardManager

class TrendsPublishViewController: UIViewController {
    var images:[UIImage] = []
    lazy var backBtn: UIButton = {
        let value = UIButton.init(frame: .init(x: 0, y: 0, width: 32, height: 32))
        value.i_radius = 4
        value.tintColor = .label
        value.setTitle("取消", for: .normal)
        value.setTitleColor(.label, for: .normal)
        value.setBlockFor(.touchUpInside) {[weak self] _ in
            self?.navigationController?.dismiss(animated: true)
        }
        return value
    }()
    lazy var pushBtn: UIButton = {
        let value = UIButton.init(frame: .init(x: 0, y: 0, width: 32, height: 32))
        value.backgroundColor = .theme.withAlphaComponent(0.15)
        value.setTitle("发布", for: .normal)
        value.setTitleColor(.theme, for: .normal)
        value.setBlockFor(.touchUpInside) {[weak self] _ in
            self?.navigationController?.dismiss(animated: true)
        }
        value.i_radius = 8
        return value
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let value = UICollectionViewFlowLayout()
        value.minimumLineSpacing = 8
        value.minimumInteritemSpacing = 4
        return value
    }()
    
    lazy var collectionView: UICollectionView = {
        let value = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        value.delegate = self
        value.dataSource = self
        value.register(ImageItemCell.self, forCellWithReuseIdentifier: "ImageItemCell")
        return value
    }()
    lazy var textView: IQTextView = {
        let vlaue = IQTextView()
        vlaue.placeholder = "编辑一段关于设计图的描述"
        vlaue.backgroundColor = .gray.withAlphaComponent(0.15)
        vlaue.font = .systemFont(ofSize: 16)
        return vlaue
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "发布设计图"
        makeUI()
        makeLayout()
    }
    
    func makeUI(){
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = .init(customView: backBtn)
        navigationItem.rightBarButtonItem = .init(customView: pushBtn)
        view.addSubview(textView)
        view.addSubview(collectionView)
    }
    
    func makeLayout(){
        textView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(120)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(12)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.bottom.equalToSuperview()
        }
        pushBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize.init(width: 64, height: 32))
        }
    }


}
extension TrendsPublishViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count+1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageItemCell", for: indexPath) as! ImageItemCell
        if indexPath.row < images.count{
            cell.imgView.image = images[indexPath.row]
        }else{
            cell.imgView.image = .init(named: "placeholder.image")
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.size.width-16-24
        let cw = w/3
        return .init(width: cw, height: cw)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let playerVC = LCAVPlayerViewController()
//        self.present(playerVC, animated: true){ [weak playerVC,self] in
//            playerVC?.play(item: .init(asset: self.asset))
//        }
    }
}
extension TrendsPublishViewController{
    class ImageItemCell:UICollectionViewCell{
        public lazy var imgView: UIImageView = {
             let value = UIImageView()
            value.contentMode = .scaleAspectFill
             return value
         }()
        public override init(frame: CGRect) {
            super.init(frame: frame)
            makeUI()
            makeLayout()
        }

        open func makeUI(){
            contentView.addSubview(imgView)
        }
        
        open  func makeLayout(){
            imgView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
