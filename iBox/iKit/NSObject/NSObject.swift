//
//  NSObject.swift
//  iApple
//
//  Created by mac on 2023/2/25.
//

import Foundation

public extension NSObject{
    static var i_className:String{
        return NSStringFromClass(self)
    }
    
}
