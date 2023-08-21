//
//  CloudSqlQuery.swift
//  iApple
//
//  Created by admin on 2023/8/6.
//

import Foundation
import CloudKit
public class CloudSqlQuery:ISqlManage{
   
    var identifier:String
    public init(dbpath: String,identifier:String, passWord: String? = nil) {
        self.identifier = identifier
        super.init(dbpath: dbpath,passWord: passWord)
    }

    public override func createTable(recordType: String) async throws {
        
        try await super.createTable(recordType: recordType)
        try await database.addColumn(tableName: recordType, name: "recordID", type: "TEXT")
        try await database.addColumn(tableName: recordType, name: "asyncDate", type: "DATE")
    }
    public func add(keyvalues: [String : SqlValueProtocol], recordType: String) async throws {
        var keyvalues = keyvalues
        keyvalues["asyncDate"] = nil
        try await super.setkeyValues(keyvalues, recordType: recordType)
    }
  
    
    // 删
    public override func delete(uuid: String, recordType: String) async throws -> Bool {
        let predicate = String.init(format: " uuid = '%@' ", uuid)
        let result = try await database.fetch(tableName: recordType, predicate: predicate)
        var results:[[String : SqlValueProtocol]] = []
        while result.next() {
            if let value = result.resultDictionary as? [String: SqlValueProtocol] {
                results.append(value)
            }
        }
        guard let updateKeyvales = results.first else{
            return true
        }
        if updateKeyvales["recordID"] is String{
            let keyvalues = [
                "uuid":uuid,
                "isdelete":1
            ] as [String : SqlValueProtocol]
            try await  self.update(keyvalues: keyvalues, recordType: recordType)
        }else{
            return try await super.delete(uuid: uuid, recordType: recordType)
        }
        return true
    }
   
  
    // 改
    public func update(keyvalues: [String : SqlValueProtocol], recordType: String) async throws {
        var keyvalues = keyvalues
        keyvalues["asyncDate"] = nil
        try await setkeyValues(keyvalues, recordType: recordType)
    }
   
   
    // 增
    public func merge( keyvalues:[String:SqlValueProtocol],recordType:String) async throws{
       
        try await database.setkeysValues(keyvalues, tableName: recordType)
    }
}

// 推送到 clould
extension CloudSqlQuery{
    
    public func pushToClould(recordType:String)async throws{
        debugPrint("推送到 clould begin")
        let predicate = " asyncDate is NULL "
        let results = try await fetchToDic(recordType: recordType, predicate: predicate)
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
            keyvalues["asyncDate"] = record.modificationDate
            keyvalues["recordID"] = record.recordID.recordName
            try await merge(keyvalues: keyvalues, recordType: recordType)
            index+=1
        }
        debugPrint("推送到 clould end")
        
        
    }
}

extension CloudSqlQuery{
    
    func lastMergedate(recordType:String) throws->Date{
        var lastAsyncDate:Date = .init(timeIntervalSince1970: 0)
        let sql = """
Select max(asyncDate) as asyncDate from \(recordType)
"""
        database.open()
        let result = try database.executeQuery(sql, values: nil)
        while result.next(){
            
            lastAsyncDate = result.date(forColumn:"asyncDate") ?? .init(timeIntervalSince1970: 0)
        }
        database.close()
        
       
        return lastAsyncDate
       
    }
    // 拉取远端数据
    public func pullClould(recordType:String) async throws{
    
        let lastDate = try lastMergedate(recordType: recordType)
        debugPrint("拉取远端数据 begin lastDate:\(lastDate)")
        let content = CKContainer.init(identifier: identifier)
        let preducate = NSPredicate.init(format: "modificationDate>%@",lastDate  as CVarArg)
        let query = CKQuery.init(recordType: recordType, predicate: preducate)
        let (result,_) = try await content.publicCloudDatabase.records(matching: query)
        debugPrint("拉取远端数据 \(recordType)更新\(result.count)条数据")
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
            keyvalues["asyncDate"] = record.modificationDate
            keyvalues["recordID"] = record.recordID.recordName
            keyvalues["creationDate"] = record.creationDate
            keyvalues["modificationDate"] = record.modificationDate
            keyvalues["modifiedUser"] = record.lastModifiedUserRecordID?.recordName
            keyvalues["creatorUser"] = record.creatorUserRecordID?.recordName
            
            try await merge(keyvalues: keyvalues, recordType: recordType)
            debugPrint("拉取远端数据 end")
        }
    }
}
