//
//  iBanderCollectionCell.swift
//  Alamofire
//
//  Created by admin on 2023/4/19.
//

import Foundation
import UIKit

open class CommitBtn:UIButton{
 
    public override init(frame: CGRect) {
        super.init(frame: frame)
        gradientLayer?.locations = [0,1]
        gradientLayer?.startPoint = .init(x: 0, y: 0.5)
        gradientLayer?.endPoint = .init(x: 1, y: 0.5)
        gradientLayer?.colors = [UIColor.purple,UIColor.blue].map{ $0.cgColor }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open override class var layerClass: AnyClass{
        CAGradientLayer.self
    }
    open var gradientLayer: CAGradientLayer?{
        guard let g_layer = layer as? CAGradientLayer else{return nil}
        return g_layer
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        i_radius = self.height/2
    }
   
}

