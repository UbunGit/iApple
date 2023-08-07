//
//  SqlQuery.swift
//  iApple
//
//  Created by mac on 2023/7/7.
//

import Foundation
import FMDB
import SQLCipher
open class ISqlManage{
    
    var dbUrl:URL
    
    var database:FMDatabase
    
    public init(dbUrl:URL,passWord:String? = nil) {
        
//        let isexit = FileManager.default.fileExists(atPath: dbUrl.path)
        self.dbUrl = dbUrl
        self.database = .init(url: dbUrl)
    }
    
    
    
    public func createTable(recordType:String) async throws{
        if try await database.isTable(tableName: recordType){
            return
        }
        let sql = """
            CREATE TABLE IF NOT EXISTS \(recordType) (
                uuid TEXT PRIMARY KEY NOT NULL,
                creationDate DATE,
                modificationDate DATE,
                isdelete INTEGER
            );
            """
        try await database.autoExecute { db in
            let result = db.executeStatements(sql)
            if result == false {
                print("Error creating table: \(database.lastErrorMessage())")
                return
            }
        }
    }
    
    // 增
    public func add( keyvalues:[String:SqlValueProtocol],recordType:String) async throws{
        if try await database.isTable(tableName: recordType) == false{
            try await createTable(recordType: recordType)
        }
     
        if let uuid = keyvalues["uuid"] as? String,
           try await fetchToDic(recordType: recordType, predicate: String.init(format: " uuid = '%@' ",uuid)).count>0{
            try await update(keyvalues: keyvalues, recordType: recordType)
        }else{
            var keyvalues = keyvalues
            keyvalues["uuid"] = UUID().uuidString
            keyvalues["creationDate"] = Date()
            keyvalues["modificationDate"] = Date()
            try await database.setkeysValues(keyvalues, tableName: recordType)
        }
    }
    
    // 删
    public func delete(uuid:String,recordType:String) async throws {
        if try await database.isTable(tableName: recordType) == false{
            try await createTable(recordType: recordType)
        }
        let predicate = String.init(format: " uuid = '%@' ", uuid)
        try await database.delete(tableName: recordType, predicate: predicate)
    }
  
    // 改
    public func update(keyvalues:[String:SqlValueProtocol],recordType:String) async throws{
        if try await database.isTable(tableName: recordType) == false{
            try await createTable(recordType: recordType)
        }
        guard keyvalues["uuid"] is String else{
            throw ISqliteError.sqlUpdateError
        }
        var updateKeyvales = keyvalues
        updateKeyvales["creationDate"] = Date()
        updateKeyvales["modificationDate"] = Date()
        updateKeyvales["asyncDate"] = nil
        keyvalues.forEach { (key: String, value: SqlValueProtocol) in
            updateKeyvales[key] = value
        }
        try await database.setkeysValues(updateKeyvales, tableName: recordType)
    }
    
    // 查
    public func fetch(recordType:String,predicate:String?) async throws->FMResultSet{
        if try await database.isTable(tableName: recordType) == false{
            try await createTable(recordType: recordType)
        }
        return try await database.fetch(tableName: recordType, predicate: predicate)
    }
    
    // 查
    public func fetchToDic(recordType:String,predicate:String?) async throws->[[String : SqlValueProtocol]]{
        if try await database.isTable(tableName: recordType) == false{
            try await createTable(recordType: recordType)
        }
        let result = try await database.fetch(tableName: recordType, predicate: predicate)
        var results:[[String : SqlValueProtocol]] = []
        while result.next() {
            if let value = result.resultDictionary as? [String: SqlValueProtocol] {
                results.append(value)
            }
        }
        return results
    }
    
    
}


