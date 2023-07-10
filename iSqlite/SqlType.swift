//
//  SqlType.swift
//  Pods
//
//  Created by mac on 2023/7/1.
//

import Foundation
import CloudKit

#if os(macOS)
import AppKit
#else
import UIKit
#endif
public protocol SqlValueProtocol:CKRecordValueProtocol {
    var sqltype:String? {get}
    
    var cloudKitData:CKRecordValueProtocol {get}
    
    var sqlData:CKRecordValueProtocol? {get}
}
public extension SqlValueProtocol{
    var sqlData: CKRecordValueProtocol? {
        return self
    }
    var cloudKitData: CKRecordValueProtocol {
        return self
    }
}

extension Optional: SqlValueProtocol{
    public var sqltype: String? {
        switch self {
        
        case .some(let value as SqlValueProtocol):
            return value.sqltype
        case .some(_):
            return "TEXT"
        case .none:
            return nil
      
        }
    }
    public var cloudKitData:CKRecordValueProtocol{
        switch self {
        
        case .some(let value as SqlValueProtocol):
            return value.cloudKitData
        case .some(_):
            return self
        case .none:
            return self
      
        }
    }
    
    public var sqlData: CKRecordValueProtocol? {
        switch self {
        
        case .some(let value as SqlValueProtocol):
            return value.sqlData
        case .some(_):
            return self.sqlData
        case .none:
            return nil
      
        }
    }
}


extension Int:SqlValueProtocol{
    public var cloudKitData: CKRecordValueProtocol {
        return self
    }
    
    public var sqltype:String?{
        return "INTEGER"
    }
}
extension Int8:SqlValueProtocol{
    public var sqltype:String?{
        return "INTEGER"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self
    }
}
public extension Int16{
    var sqltype:String?{
        return "INTEGER"
    }
    var cloudKitData: CKRecordValueProtocol {
        return self
    }
}
public extension Int32{
    var sqltype:String?{
        return "INTEGER"
    }
    var cloudKitData: CKRecordValueProtocol {
        return self
    }
}
extension Int64:SqlValueProtocol{
    public var sqltype:String?{
        return "INTEGER"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self
    }
}
extension String:SqlValueProtocol{
    public var sqltype:String?{
        return "TEXT"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self
    }
}

extension Bool:SqlValueProtocol{
    public var sqltype:String?{
        return "INTEGER"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self
    }
}

extension Data:SqlValueProtocol{
    
    public var sqltype:String?{
        return "BLOB"
    }
}
extension NSData:SqlValueProtocol{
    public var sqltype:String?{
        return "DATE"
    }
}

extension Date:SqlValueProtocol{
    
    public var sqltype:String?{
        return "DATE"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self
    }
}




extension Double:SqlValueProtocol{
    public var sqltype:String?{
        return "FLOAT"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self
    }
}

extension Float:SqlValueProtocol{
    public var sqltype:String?{
        return "FLOAT"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self
    }
}
extension NSNumber:SqlValueProtocol{
    public var sqltype:String?{
        return "FLOAT"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self
    }
}
extension NSString:SqlValueProtocol{
    public var sqltype:String?{
        return "TEXT"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self
    }
}
extension NSNull:SqlValueProtocol{
    public var sqltype:String?{
        return "NULL"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self
    }
}

//#define SQLITE_INTEGER  1
//#define SQLITE_FLOAT    2
//#define SQLITE_BLOB     4
//#define SQLITE_NULL     5
//# undef SQLITE_TEXT



