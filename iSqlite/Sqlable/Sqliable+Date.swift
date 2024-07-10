//
//  SqliAble.swift
//  iPods
//
//  Created by admin on 2023/10/13.
//

import Foundation
import CloudKit

extension Date:Sqlable{
    
    public var sqltype:String?{
        return "DATE"
    }
    
    public var cloudValue: CKRecordValueProtocol {
        return self
    }
}
