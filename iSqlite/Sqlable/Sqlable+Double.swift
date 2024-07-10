//
//  Sqlable+Double.swift
//  iPods
//
//  Created by admin on 2023/10/13.
//

import Foundation
import CloudKit
extension Double:Sqlable{
    public var sqltype:String?{
        return "FLOAT"
    }
    public var cloudValue: CKRecordValueProtocol {
        return self
    }
}
