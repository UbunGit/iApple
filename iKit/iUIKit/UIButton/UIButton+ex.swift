//
//  UIButton+ex.swift
//  iApple
//
//  Created by mac on 2023/6/21.
//

import Foundation
public extension UIButton{
    
    enum ButtonEdgeInsetsStyle {
        case top, left, bottom, right
    }
    
    func setEdgeInsets(with style: NSDirectionalRectEdge, space: CGFloat) {
        self.layoutIfNeeded()
        guard let imageView = self.imageView,
              let titleLabel = self.titleLabel else {
            return
        }
        
        
        let imageWidth = imageView.intrinsicContentSize.width
        let imageHeight = imageView.intrinsicContentSize.height
        
        let labelWidth: CGFloat = titleLabel.intrinsicContentSize.width
        let labelHeight: CGFloat = titleLabel.intrinsicContentSize.height
        
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-space/2.0, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight-space/2.0, right: 0)
        case .leading:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-space/2.0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight-space/2.0, left: -imageWidth, bottom: 0, right: 0)
        case .trailing:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+space/2.0, bottom: 0, right: -labelWidth-space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth-space/2.0, bottom: 0, right: imageWidth+space/2.0)
        default:
            break
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
        
        
    }
    
    var font:UIFont?{
        set{
            titleLabel?.font = newValue
        }
        get{
            titleLabel?.font
        }
    }
}

