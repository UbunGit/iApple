//
//  UIButton.swift
//  Pods-Sample
//
//  Created by admin on 2022/11/6.
//

import Foundation

extension UIButton{
    
    func cfg_back(){
    
        setImage(UIImage(named: "arrow.left"), for: .normal)
        backgroundColor = tintColor.withAlphaComponent(0.75)
        i_radius = 16
    }
    
    func cfg_commit(){
        backgroundColor = tintColor
        setTitleColor(.white, for: .normal)
        i_radius = 27
    }
}
