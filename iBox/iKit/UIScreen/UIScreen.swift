//
//  File.swift
//  iApple
//
//  Created by mac on 2023/2/28.
//

import Foundation
public let i_screen_w = UIScreen.main.bounds.size.width
public let i_screen_h = UIScreen.main.bounds.size.height
public extension UIScreen{
    
    static  var safeAreaInsets:UIEdgeInsets{
        guard let safe = UIApplication.shared.delegate?.window??.safeAreaInsets else{
            return .zero
        }
        return  safe
    }
    

}
