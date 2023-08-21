//
//  ICloudKitDataPro.swift
//  iApple
//
//  Created by mac on 2023/6/30.
//

import Foundation
import CloudKit
import FMDB
import CoreData


open class ICloudSqlObject{
    
    var keyValues:[String:SqlValueProtocol] = [:]
    
    public init(keyValues:[String:SqlValueProtocol]) {
        self.keyValues = keyValues
    }
    public var uuid:String{
        return keyValues["uuid"] as! String
    }
    public lazy var isDelete: Bool = {
        return keyValues["isdelete"] as? Int == 1
    }()
}



extension FMDatabase{

    
    func lastModificationDate(tableName:String)async throws ->Date?{
        var lastModificationDate:Date? = nil
        let sql = "SELECT MAX(modificationDate) as max FROM \(tableName)"
        try await autoExecute { db in
            let resultSet = try db.executeQuery(sql, values: nil)
            guard resultSet.next() else { return }
            lastModificationDate = resultSet.date(forColumn: "max")
        }
        return lastModificationDate
    }
    
    
}



enum ICloudKitError:Error{
    case sqlUpdateUUIDISNULL
    case sqlUpdateDataISNULL
    case sqlDeleteError
}




