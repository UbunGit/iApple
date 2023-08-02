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

public class CloudSqlQuery:NSObject{
    var recordType:String
    
    var identifier:String = "iCloud.com.i.health"
    public init(recordType: String) {
        self.recordType = recordType
        
    }
    // MARK:DB
    static var sqlFile: String{
        return "defual.sqlite"
    }
    
    var sqlPath:URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = documentDirectory.appendingPathComponent("sql")
        if FileManager.default.isExecutableFile(atPath: url.path) == false{
            try! FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        }
        return url.appendingPathComponent("defual.db")
    }
    
    var sqlDatabase:FMDatabase {
        return FMDatabase(url: sqlPath)
    }
    
    func setUp()async throws{
        try await createTable()
    }
    
    private func createTable() async throws{
        
        let sql = """
            CREATE TABLE IF NOT EXISTS \(recordType) (
                uuid TEXT PRIMARY KEY NOT NULL,
                recordID TEXT,
                creationDate DATE,
                modificationDate DATE,
                asyncDate DATE,
                modifiedByDevice TEXT,
                modifiedUser TEXT,
                creatorUser TEXT,
                isdelete INTEGER
            );
            """
        try await sqlDatabase.autoExecute { db in
            db.executeStatements(sql)
        }
        
    }
    
    // 增
    public func add(keyvalues:[String:SqlValueProtocol]) async throws{
        try await setUp()
        
        if keyvalues["uuid"] is String {
            try await update(keyvalues: keyvalues)
        }else{
            var keyvalues = keyvalues
            keyvalues["uuid"] = UUID().uuidString
            keyvalues["creationDate"] = Date()
            keyvalues["modificationDate"] = Date()
            try await sqlDatabase.setkeysValues(keyvalues, tableName: recordType)
        }
    }
    
    // 删
    
    public func delete(uuid:String) async throws {
        try await setUp()
        let keyvalues = [
            "uuid":uuid,
            "isdelete":1
        ] as [String : SqlValueProtocol]
        let predicate = String.init(format: " uuid = '%@' ", uuid)
        let result = try await sqlDatabase.fetch(tableName: recordType, predicate: predicate)
        var results:[[String : SqlValueProtocol]] = []
        while result.next() {
            if let value = result.resultDictionary as? [String: SqlValueProtocol] {
                results.append(value)
            }
        }
        guard var updateKeyvales = results.first else{
            return
        }
        if updateKeyvales["recordID"] is String{
            updateKeyvales["creationDate"] = Date()
            updateKeyvales["modificationDate"] = Date()
            updateKeyvales["asyncDate"] = nil
            keyvalues.forEach { (key: String, value: SqlValueProtocol) in
                updateKeyvales[key] = value
            }
            try await sqlDatabase.setkeysValues(updateKeyvales, tableName: recordType)
        }else{
            try await realDelete(uuid: uuid)
        }
    }
    
    public func realDelete(uuid:String) async throws {
        let predicate = String.init(format: " uuid = '%@' ", uuid)
        try await sqlDatabase.delete(tableName: recordType, predicate: predicate)
    }
    public func realDelete(recordID:String) async throws {
        let predicate = String.init(format: " recordID = '%@' ", recordID)
        try await sqlDatabase.delete(tableName: recordType, predicate: predicate)
    }
    // 改
    public func update(keyvalues:[String:SqlValueProtocol]) async throws{
        try await setUp()
        guard let uuid = keyvalues["uuid"] as? String else{
            throw ICloudKitError.sqlUpdateUUIDISNULL
        }
        let predicate = String.init(format: " uuid = '%@' ", uuid)
        let result = try await sqlDatabase.fetch(tableName: recordType, predicate: predicate)
        var results:[[String : SqlValueProtocol]] = []
        while result.next() {
            if let value = result.resultDictionary as? [String: SqlValueProtocol] {
                results.append(value)
            }
        }
        guard var updateKeyvales = results.first else{
            throw ICloudKitError.sqlUpdateDataISNULL
        }
        updateKeyvales["creationDate"] = Date()
        updateKeyvales["modificationDate"] = Date()
        updateKeyvales["asyncDate"] = nil
        keyvalues.forEach { (key: String, value: SqlValueProtocol) in
            updateKeyvales[key] = value
        }
        try await sqlDatabase.setkeysValues(updateKeyvales, tableName: recordType)
    }
    
    public func merge(keyvalues:[String:SqlValueProtocol]) async throws{
        try await setUp()
        var keyvalues = keyvalues
        if keyvalues["uuid"] is String == false{
            keyvalues["uuid"] = UUID().uuidString
        }
        try await sqlDatabase.setkeysValues(keyvalues, tableName: recordType)
    }
    
    
    // 查
    public func fetch(predicate:String? = nil,ignoreDelete:Bool = true) async throws ->[[String:SqlValueProtocol]]{
        try await setUp()
        let deletestr:String = (predicate==nil) ? " isdelete is not 1 " : " and isdelete is not 1 "
        var newPredicate = predicate
        if ignoreDelete{
            newPredicate = (predicate ?? "") + deletestr
        }
        
        let result = try await sqlDatabase.fetch(tableName: recordType, predicate: newPredicate)
        var results:[[String : SqlValueProtocol]] = []
        while result.next() {
            if let value = result.resultDictionary as? [String: SqlValueProtocol] {
                results.append(value)
            }
        }
        return results
        
    }
    
    // 推送到 clould
    public func push()async throws{
        debugPrint("推送到 clould begin")
        let predicate = " asyncDate is NULL "
        let results = try await fetch(predicate: predicate,ignoreDelete: false)
        var modified:[CKRecord] = []
        var iterator = results.makeIterator()
        while let item  =  iterator.next(){
            if let recordID = item["recordID"] as? String{
                
                let record =  CKRecord.init(recordType: recordType,recordID: .init(recordName: recordID))
                item.forEach { (key: String, value: SqlValueProtocol) in
                    if ["creationDate","modificationDate","modifiedUser","asyncDate","recordID","creatorUser","modifiedByDevice"].contains(key) == false{
                        if let value = value.cloudKitData as? __CKRecordObjCValue{
                            record.setObject(value, forKey: key)
                        }else{
                            record.setObject(nil, forKey: key)
                        }
                    }
                }
                modified.append(record)
                
            }else{
                let record =  CKRecord.init(recordType: recordType)
                item.forEach { (key: String, value: SqlValueProtocol) in
                    if ["creationDate","modificationDate","modifiedUser","asyncDate","recordID","creatorUser","modifiedByDevice"].contains(key) == false{
                        if let value = value.cloudKitData as? __CKRecordObjCValue{
                            record.setObject(value, forKey: key)
                        }else{
                            record.setObject(nil, forKey: key)
                        }
                    }
                }
                modified.append(record)
            }
            
        }
        if modified.count == 0{
            debugPrint("推送到 clould end")
            return
        }
        let content = CKContainer.init(identifier: identifier)
        let (modifiedResults, _) = try await content.publicCloudDatabase.modifyRecords(saving: modified, deleting: [],savePolicy: .allKeys)
        
        var modifiedIterator = modifiedResults.makeIterator()
        var index = 0
        while let modifiedItem = modifiedIterator.next() {
            debugPrint("推送到 clould\(index)/\(modifiedResults.count)")
            let record = try modifiedItem.1.get()
            let values = record.allKeys()
            var keyvalues:[String:SqlValueProtocol] = [:]
            values.forEach { key in
                keyvalues[key] = record[key] as? any SqlValueProtocol
            }
            keyvalues["asyncDate"] = Date()
            keyvalues["recordID"] = record.recordID.recordName
            try await update(keyvalues: keyvalues)
            index+=1
        }
        debugPrint("推送到 clould end")
        
        
    }
    // 拉取远端数据
    public func pull()async throws{
        debugPrint("拉取远端数据 begin")
        let content = CKContainer.init(identifier: identifier)
        let preducate = NSPredicate(value: true)
        let query = CKQuery.init(recordType: recordType, predicate: preducate)
        let (result,_) = try await content.publicCloudDatabase.records(matching: query)
        var iterator  = result.makeIterator()
        while let item = iterator.next() {
            let record = try item.1.get()
            let values = record.allKeys()
            var keyvalues:[String:SqlValueProtocol] = [:]
            values.forEach { key in
                keyvalues[key] = record[key].sqlData as? any SqlValueProtocol
            }
            if record["uuid"] is String == false{
                keyvalues["uuid"] = record.recordID.recordName
            }
            keyvalues["asyncDate"] = Date()
            keyvalues["recordID"] = record.recordID.recordName
            keyvalues["creationDate"] = record.creationDate
            keyvalues["modificationDate"] = record.modificationDate
            keyvalues["modifiedUser"] = record.lastModifiedUserRecordID?.recordName
            keyvalues["creatorUser"] = record.creatorUserRecordID?.recordName
            
            try await merge(keyvalues: keyvalues)
            debugPrint("拉取远端数据 end")
        }
    }
}





