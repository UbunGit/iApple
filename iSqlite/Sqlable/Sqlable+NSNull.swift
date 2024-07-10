//
//  Sqlable+NSNull.swift
//  iPods
//
//  Created by admin on 2023/10/13.
//

import Foundation
import CloudKit
extension NSNull:Sqlable{
    public var sqltype:String?{
        return "NULL"
    }
}
