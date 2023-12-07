//
//  Sqlable+NSNumber.swift
//  iApple
//
//  Created by admin on 2023/10/13.
//

import Foundation
import CloudKit
extension NSNumber:Sqlable{
    public var sqltype:String?{
        return "FLOAT"
    }
}

