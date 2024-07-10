//
//  PathView.swift
//  CocoaLumberjack
//
//  Created by admin on 2023/12/15.
//

import Foundation
import UIKit

public protocol IMultipleMeidaSelectViewDelegate:AnyObject{
    func updateMeida(index:IndexPath)
    func selectMeida()
}
open class IMultipleMeidaSelectView:IBaseView{

   public weak var delegate:IMultipleMeidaSelectViewDelegate? = nil
    
    public var images:[UIImage] = []{
        didSet{
            makeLayout()
        }
    }
    public lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.sectionInset =  .init(top: 8, left: 12, bottom: 12, right: 12)
        let value = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        value.delegate = self
        value.dataSource = self
        value.backgroundColor = .clear
        value.i_register(cellType: ItemCell.self)
        return value
    }()
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open override func makeUI() {
        super.makeUI()
        addSubview(collectionView)
        
    }
    
    open override func makeLayout() {
        super.makeLayout()
        let item_w = (width-32)/3
        let c = images.count+1
        let line = c/3 + ((c%3>0) ? 1 : 0)
        var height = item_w*CGFloat(line)
        height += CGFloat((line-1)*8)
        height += 16
        collectionView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(height)
        }
       
    }
    open override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        makeLayout()
    }
}


extension IMultipleMeidaSelectView:I_UICollectionViewProtocol{
    
    class ItemCell:UICollectionViewCell{
        lazy var imgView: ISimpleMeidaSelectView = {
            let value = ISimpleMeidaSelectView(frame: .zero)
            value.i_radius = 12
            value.i_border(color: .placeholderText.withAlphaComponent(0.35))
            value.backgroundColor = .systemGroupedBackground
            value.tintColor = .placeholderText.withAlphaComponent(0.35)
            return value
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            makeUI()
            makeLayout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func makeUI() {
            
            addSubview(imgView)
        }
        func makeLayout() {
            imgView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count+1
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == images.count{
            let cell = collectionView.i_dequeueReusableCell(with: ItemCell.self, for: indexPath)
            cell.imgView.image = nil
            return cell
        }else{
            let cell = collectionView.i_dequeueReusableCell(with: ItemCell.self, for: indexPath)
            cell.imgView.image = images[indexPath.row]
            return cell
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.cellSize(space: 8, column: 3, ratio: 1)
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == images.count{
            delegate?.selectMeida()
        }else{
            delegate?.updateMeida(index: indexPath)
        }
        
    }
}

