//
//  Optional.swift
//  AEXML
//
//  Created by mac on 2023/3/8.
//

import Foundation
public extension String{
    func i_double(_ defual:Double = 0) -> Double{
        return Double(self) ?? defual
    }
    func i_doubleValue() -> Double?{
        return Double(self)
    }
    func i_range(of:String)->NSRange{
        let s = self as NSString
        return s.range(of: of)
    }
    
    func i_replacing(str:String, to:String) -> String{
        let s = self as NSString
        return s.replacingOccurrences(of: str, with: to)
    }
     
}

