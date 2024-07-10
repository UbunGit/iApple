//
//  IBaseView.swift
//  iPods
//
//  Created by admin on 2023/9/15.
//

import UIKit

open class IBaseView: UIView {

    public override init(frame: CGRect) {
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
