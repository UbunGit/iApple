//
//  iBanderCollectionCell.swift
//  Alamofire
//
//  Created by admin on 2023/4/19.
//

import Foundation
import UIKit
import SnapKit
import Combine
open class IBanderView<T:Any>:UIView,I_UICollectionViewProtocol{
    
    public var selectIndexChangeBlock:(()->())? = nil
    public var selectIndex:IndexPath = .init(row: 0, section: 0)
    public var dataSouce:[T] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
   public lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let value = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        value.i_register(cellType: DefualCell.self)
        value.isPagingEnabled = true
        value.delegate = self
        value.dataSource = self
        return value
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func makeUI(){
        addSubview(collectionView)
    }
    open func makeLayout(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSouce.count
    }
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.i_dequeueReusableCell(with: DefualCell.self, for: indexPath)
        let rowData = dataSouce[indexPath.row]
        if let image = rowData as? UIImage {
            cell.imgView.image = image
        }
        return cell
    }
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let w = Int(self.collectionView.bounds.width)
        let x = Int(self.collectionView.contentOffset.x)
        let index = (x+w/2) / w
        let page  = index
        selectIndex = .init(row: page, section: 0)
        selectIndexChangeBlock?()
    }
  
}

extension IBanderView{
    open  class DefualCell:UICollectionViewCell{
        public lazy var imgView: UIImageView = {
            let value = UIImageView()
            value.contentMode = .scaleAspectFill
            return value
        }()
        public override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(imgView)
            imgView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

