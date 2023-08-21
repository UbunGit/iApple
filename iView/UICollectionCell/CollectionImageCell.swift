//
//  CollectionImageCell.swift
//  CocoaAsyncSocket
//
//  Created by mac on 2023/3/21.
//

import UIKit

open class CollectionImageCell: UICollectionViewCell {
    public lazy var imageView: UIImageView = {
        let value = UIImageView()
        value.i_radius = 0.1
        return value
    }()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func makeUI(){
        addSubview(imageView)
    }
    open func makeLayout(){
        imageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

