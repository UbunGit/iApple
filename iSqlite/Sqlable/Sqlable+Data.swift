//
//  Sqlable+Data.swift
//  iPods
//
//  Created by admin on 2023/10/13.
//

import Foundation
import CloudKit

extension Data:Sqlable{
    
    public var sqltype:String?{
        return "BLOB"
    }
    public var cloudValue: CKRecordValueProtocol {
        return self.ckAsset
    }
    public var sqlValue: CKRecordValueProtocol?{
        let key:String = self.i_md5 ?? UUID().uuidString
        let cacheurl = self.i_cacheUrl.appendingPathComponent(key)
        try! self.write(to: cacheurl)
        return key
    }
}

extension NSData:Sqlable{
    public var sqltype:String?{
        return "BLOB"
    }
    public var cloudValue: CKRecordValueProtocol {
        return self.ckAsset
    }
    public var sqlValue: CKRecordValueProtocol?{
        let data = self as Data
        let key:String = data.i_md5 ?? UUID().uuidString
        let cacheurl = self.i_cacheUrl.appendingPathComponent(key)
        try! self.write(to: cacheurl)
        return key
    }
}
