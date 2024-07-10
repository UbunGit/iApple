//
//  Date.swift
//  iPods
//
//  Created by mac on 2023/2/25.
//

import Foundation

public extension Double {
    // max 最多小数位
     func decimalStr(_ max: Int = 5) -> String {
        let format = NumberFormatter.init()
        format.numberStyle = .decimal
        format.minimumFractionDigits = 0 // 最少小数位
        format.maximumFractionDigits = max // 最多小数位
        format.formatterBehavior = .default
        format.roundingMode = .down // 小数位以截取方式。不同枚举的截取方式不同
        return format.string(from: NSNumber(value: self)) ?? ""
    }
    
   
}
public extension Double{
    
    func i_formatter() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        let absNumber = abs(self)
        if absNumber >= 100000 {
            let formattedNumber = absNumber / 10000
            let suffix = "w"
            return "\(formatter.string(from: NSNumber(value: formattedNumber)) ?? "")\(suffix)"
        } else if absNumber >= 10000 {
            let formattedNumber = absNumber / 1000
            let suffix = "k"
            return "\(formatter.string(from: NSNumber(value: formattedNumber)) ?? "")\(suffix)"
        } else {
            return formatter.string(from: NSNumber(value: self)) ?? ""
        }
    }
    
    func i_stringValue()->String{
        return String(self)
    }
}

