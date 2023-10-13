//
//  Sqlable+String.swift
//  iApple
//
//  Created by admin on 2023/10/13.
//

import Foundation
import CloudKit
extension String:Sqlable{
    public var sqltype:String?{
        return "TEXT"
    }
    public var cloudValue: CKRecordValueProtocol {
        return self
    }
}

extension NSString:Sqlable{
    public var sqltype:String?{
        return "TEXT"
    }
    public var cloudValue: CKRecordValueProtocol {
        return self
    }
}
