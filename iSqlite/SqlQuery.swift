//
//  SqlQuery.swift
//  iApple
//
//  Created by mac on 2023/7/7.
//

import Foundation
import FMDB
public class SqlManage{
    
    var dbUrl:URL
    
    var database:FMDatabase
    
    public init(dbUrl:URL){
        
        self.dbUrl = dbUrl
        self.database = .init(url: dbUrl)
    }
    
    func createTable(recordType:String) async throws{
        
        let sql = """
            CREATE TABLE IF NOT EXISTS \(recordType) (
                uuid TEXT PRIMARY KEY NOT NULL,
                creationDate DATE,
                modificationDate DATE,
                isdelete INTEGER
            );
            """
        try await database.autoExecute { db in
            db.executeStatements(sql)
        }
    }
    
    // 增
    public func add( keyvalues:[String:SqlValueProtocol],recordType:String) async throws{
        if try await database.isTable(tableName: recordType) == false{
            try await createTable(recordType: recordType)
        }
        if keyvalues["uuid"] is String {
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
        guard let uuid = keyvalues["uuid"] as? String else{
            throw ISqliteError.sqlUpdateError
        }
        let predicate = String.init(format: " uuid = '%@' ", uuid)
        let result = try await database.fetch(tableName: recordType, predicate: predicate)
        var results:[[String : SqlValueProtocol]] = []
        while result.next() {
            if let value = result.resultDictionary as? [String: SqlValueProtocol] {
                results.append(value)
            }
        }
        guard var updateKeyvales = results.first else{
            throw ISqliteError.sqlUpdateError
        }
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
}


