//
//  Sqlable+Bool.swift
//  iApple
//
//  Created by admin on 2023/10/13.
//

import Foundation
import CloudKit
extension Bool:Sqlable{
    public var sqltype:String?{
        return "INTEGER"
    }
    
    public var cloudValue: CKRecordValueProtocol {
        return self
    }
}
