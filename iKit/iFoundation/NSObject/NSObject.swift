//
//  NSObject.swift
//  iPods
//
//  Created by mac on 2023/2/25.
//

import Foundation

public extension NSObject{
    static var i_className:String{
        return NSStringFromClass(self)
    }
    
    static func i_properties()->[String]{
        let mirror = Mirror(reflecting: self.init().self)
        var properties: [String] = []
        for child in mirror.children {
            if let label = child.label {
                properties.append(label)
            }
        }
        return properties
    }
    
}
