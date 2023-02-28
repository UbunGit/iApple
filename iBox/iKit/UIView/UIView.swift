//
//  UIView.swift
//  iApple
//
//  Created by mac on 2023/2/28.
//

import Foundation
@IBDesignable
public extension UIView{
    
    @objc var i_radius: CGFloat {
        set {
            layer.cornerRadius = newValue
            if newValue>0 {
                layer.masksToBounds = true
            }else{
                layer.masksToBounds = false
            }
        }
        get {
            layer.cornerRadius
        }
    }
}
