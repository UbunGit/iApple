//
//  Sqlable.swift
//  Alamofire
//
//  Created by admin on 2023/10/13.
//

import Foundation
import CloudKit

//#define SQLITE_INTEGER  1
//#define SQLITE_FLOAT    2
//#define SQLITE_BLOB     4
//#define SQLITE_NULL     5
//# undef SQLITE_TEXT

public protocol Sqlable:CKRecordValueProtocol {
    
    // 返回数据在db中存储的类型 sql类型 TEXT,INTEGER...
    var sqltype:String? {get}
    
    var sqlValue:CKRecordValueProtocol? {get}
    
    var cloudValue:CKRecordValueProtocol {get}

    var ckAsset:CKAsset? {get}
    
    var imageValue:UIImage?{get}
}

public extension Sqlable{
    var sqlValue: CKRecordValueProtocol? {
        return self
    }
    var cloudValue: CKRecordValueProtocol {
        return self
    }
    var i_cacheUrl:URL{
        let document = FileManager.documnetUrl!
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
        let path = i_cacheUrl.appendingPathComponent(s)
        return .init(fileURL:path)
    }
    
    var imageValue:UIImage?{
        guard let s = self as? String else{
            return nil
        }
        let path = i_cacheUrl.appendingPathComponent(s)
        return .init(contentsOfFile: path.path)
    }
}
