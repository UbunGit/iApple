//
//  Date.swift
//  iApple
//
//  Created by mac on 2023/2/25.
//

import Foundation
public extension Double{
    
    func formatter() -> String {
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
}

