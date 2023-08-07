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
    
    var ckAsset:CKAsset? {get}
}
public extension SqlValueProtocol{
    var sqlData: CKRecordValueProtocol? {
        return self
    }
    var cloudKitData: CKRecordValueProtocol {
        return self
    }
    var cacheUrl:URL{
        let document = FileManager.documnetUrl
        let cache = document.appendingPathComponent("iassert")
        if FileManager.default.fileExists(atPath: cache.path) == false{
           try! FileManager.default.createDirectory(at: cache, withIntermediateDirectories: false)
        }
        return cache
    }
    var ckAsset:CKAsset? {
        guard let s = self as? String else{
            return nil
        }
        let path = cacheUrl.appendingPathComponent(s)
        return .init(fileURL:path)
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
    public var cloudKitData: CKRecordValueProtocol {
        return self.ckAsset
    }
    public var sqlData: CKRecordValueProtocol?{
        let key:String = self.i_md5 ?? UUID().uuidString
        let cacheurl = self.cacheUrl.appendingPathComponent(key)
        try! self.write(to: cacheurl)
        return key
    }
}

extension NSData:SqlValueProtocol{
    public var sqltype:String?{
        return "BLOB"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self.ckAsset
    }
    public var sqlData: CKRecordValueProtocol?{
        let data = self as Data
        let key:String = data.i_md5 ?? UUID().uuidString
        let cacheurl = self.cacheUrl.appendingPathComponent(key)
        try! self.write(to: cacheurl)
        return key
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
#if os(iOS)

extension UIImage:SqlValueProtocol{
    public var sqltype:String?{
        return "TEXT"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self.ckAsset
    }
    public var sqlData: CKRecordValueProtocol?{
        let key = UUID().uuidString.appending(".png")
        let cacheurl = self.cacheUrl.appendingPathComponent(key)
        guard let data = self.pngData() else {
            return nil
        }
        try! data.write(to: cacheurl)
        return key
    }
}
#endif
#if os(macOS)
extension NSImage:SqlValueProtocol{
    public var sqltype:String?{
        return "TEXT"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self.ckAsset
    }
    public var sqlData: CKRecordValueProtocol?{
        let key = UUID().uuidString.appending(".tff")
        let cacheurl = self.cacheUrl.appendingPathComponent(key)
        guard let data = self.tiffRepresentation else {
            return nil
        }
        try! data.write(to: cacheurl)
        return key
    }
}
#endif

//#define SQLITE_INTEGER  1
//#define SQLITE_FLOAT    2
//#define SQLITE_BLOB     4
//#define SQLITE_NULL     5
//# undef SQLITE_TEXT



