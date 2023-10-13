//
//  Sqlable+Int.swift
//  iApple
//
//  Created by admin on 2023/10/13.
//

import Foundation
import CloudKit

extension Int:Sqlable{
    public var cloudValue: CKRecordValueProtocol {
        return self
    }
    
    public var sqltype:String?{
        return "INTEGER"
    }
}
extension Int8:Sqlable{
    public var sqltype:String?{
        return "INTEGER"
    }
    public var cloudValue: CKRecordValueProtocol {
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
extension Int64:Sqlable{
    public var sqltype:String?{
        return "INTEGER"
    }
    public var cloudValue: CKRecordValueProtocol {
        return self
    }
}
