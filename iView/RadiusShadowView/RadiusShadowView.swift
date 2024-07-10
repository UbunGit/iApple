//
//  ISearchTextField.swift
//  AEXML
//
//  Created by mac on 2023/3/8.
//

import Foundation
import UIKit


public class RadiusShadowView<T: UIView>: UIView {
   public lazy var body: T = {
        return T()
    }()
 
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(body)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        
        body.frame = rect
        body.layer.cornerRadius = layer.cornerRadius
        body.clipsToBounds = true
        
        layer.masksToBounds = false
 

    }
}
