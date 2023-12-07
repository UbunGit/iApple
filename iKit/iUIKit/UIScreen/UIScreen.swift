//
//  File.swift
//  iApple
//
//  Created by mac on 2023/2/28.
//

import Foundation

public extension UIScreen{
    
    static var i_safeAreaInsets:UIEdgeInsets{
        guard let safe = UIApplication.shared.delegate?.window??.safeAreaInsets else{
            return .zero
        }
        return  safe
    }
    static var i_width:CGFloat{
        return main.bounds.size.width
    }
    static var i_height:CGFloat{
        return main.bounds.size.height
    }

}
