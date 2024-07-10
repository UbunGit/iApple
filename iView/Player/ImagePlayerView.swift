//
//  ShowImageView.swift
//  iPotho
//
//  Created by mac on 2023/2/25.
//

import UIKit
import SnapKit
import SwiftUI
import SDWebImage

open class IMediaItem{
    var image:UIImage?
    var url:URL?
    var placeholderImage:UIImage?

    public init(image: UIImage) {
        self.image = image
    }
    public init(url: URL, placeholderImage: UIImage? = nil) {
        self.url = url
        self.placeholderImage = placeholderImage
    }
}
class ImagePlayerView:UIView {
    var longPressBlock:((_ cell:ImagePlayerCell)->())? = nil
    init(datas:[IMediaItem],index:Int = 0){
      
        self.datas = datas
        self.index = index
        super.init(frame: .zero)
        self.makeUI()
        self.makeLayout()
        countLab.text = "\(index+1)/\(datas.count)"
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.35) {
            
            self.collectionView.scrollToItem(at: .init(row: self.index, section: 0), at: .centeredHorizontally, animated: false)
            UIView.animate(withDuration: 0.35) {
                self.collectionView.alpha = 1
            }
        }
    }
    
    var datas:[IMediaItem]{
        didSet{
            collectionView.reloadData()
        }
    }
    var index:Int{
        didSet{
            if index<datas.count{
                self.collectionView.scrollToItem(at: .init(row: self.index, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
    }
    lazy var countLab: UILabel = {
        let value = UILabel()
        value.font = .boldSystemFont(ofSize: 20)
        value.textColor = .white
        value.i_shadow(radius: 2)
        return value
    }()

    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let value = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        value.backgroundColor = .clear
        value.isPagingEnabled = true
        value.delegate = self
        value.dataSource = self
        value.contentInsetAdjustmentBehavior = .never
        value.alpha = 0
        value.i_register(cellType: ImagePlayerCell.self, bundle: nil)
        return value
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI(){
        addSubview(collectionView)
        addSubview(countLab)
        
    }
    
    func makeLayout(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        countLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(44)
        }
        
    }
 
    
}

extension ImagePlayerView:I_UICollectionViewProtocol{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.i_dequeueReusableCell(with: ImagePlayerCell.self, for: indexPath)
        let celldata = datas[indexPath.row]
        if let image = celldata.image {
            cell.imageView.image = image
        }else if let url = celldata.url {
            cell.imageView.sd_setImage(with:url)
        }
        cell.longPressBlock = longPressBlock
        cell.tag = indexPath.row
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let w = Int(self.collectionView.bounds.width)
        let x = Int(self.collectionView.contentOffset.x)
        
        let index = (x+w/2) / w
        self.countLab.text = "\(index + 1)/\(self.datas.count)"
        
        let o = CGFloat(x%w)
        let of = abs(o-CGFloat(w/2))/CGFloat(w/2)
        self.countLab.alpha = of
    }
    
}



