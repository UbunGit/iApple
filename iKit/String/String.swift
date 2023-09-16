//
//  Optional.swift
//  AEXML
//
//  Created by mac on 2023/3/8.
//

import Foundation
public extension String{
    
    func i_range(of:String)->NSRange{
        let s = self as NSString
        return s.range(of: of)
    }
    
    func i_replacing(str:String, to:String) -> String{
        let s = self as NSString
        return s.replacingOccurrences(of: str, with: to)
    }
     
}

