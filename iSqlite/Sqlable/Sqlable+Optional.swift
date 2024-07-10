//
//  Sqlable+Optional.swift
//  iPods
//
//  Created by admin on 2023/10/13.
//

import Foundation
import CloudKit
extension Optional: Sqlable{
    public var sqltype: String? {
        switch self {
        
        case .some(let value as Sqlable):
            return value.sqltype
        case .some(_):
            return "TEXT"
        case .none:
            return nil
        }
    }
    
    public var cloudValue:CKRecordValueProtocol{
        switch self {
        
        case .some(let value as Sqlable):
            return value.cloudValue
        case .some(_):
            return self
        case .none:
            return self
      
        }
    }
    
    public var sqlValue: CKRecordValueProtocol? {
        switch self {
        
        case .some(let value as Sqlable):
            return value.sqlValue
        case .some(_):
            return self.sqlValue
        case .none:
            return nil
      
        }
    }
}
