//
//  ICollectionViewCell.swift
//  iApple
//
//  Created by admin on 2024/1/15.
//

import UIKit

open class ICollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func makeUI(){

    }
    open func makeLayout(){
 
    }
}
