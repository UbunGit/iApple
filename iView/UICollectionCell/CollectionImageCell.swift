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
        return value
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func makeUI(){
        addSubview(imageView)
    }
    func makeLayout(){
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}