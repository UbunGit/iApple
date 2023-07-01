//
//  AppDelegate.swift
//  iTest
//
//  Created by mac on 2023/6/9.
//

import UIKit
import FMDB
enum ISqliteError:Error{
    case sqlOpenError
    case tableDoesNotExist
    case sqlColumnTypeError
    case sqlUpdateError
}
public extension FMDatabase{
    
    func autoExecute(_ block: (_ db:FMDatabase)async throws -> Void) async throws {
        guard self.open() else {
            throw ISqliteError.sqlOpenError
        }
        defer {
            self.close()
            self.commit()
        }
        do {
            try await block(self)
        } catch {
            // 处理异常
            throw error
        }
    }
    
    func isTable(tableName:String) async throws->Bool{
        var isExists = false
            try await self.autoExecute { db in
                let resultSet = try  db.executeQuery("SELECT name FROM sqlite_master WHERE type='table' AND name=?", values: [tableName])
                isExists = resultSet.next()
            }
        return isExists
    }
    
    func isColumn(tableName:String,columnName: String) async throws->Bool{
        var isExists = false
        try await self.autoExecute { db in
            let sql = "PRAGMA table_info(\(tableName))"
            let resultSet = try db.executeQuery(sql, values: nil)
            while resultSet.next() {
                if let existingColumnName = resultSet.string(forColumn: "name"),
                   existingColumnName == columnName  {
                    isExists = true
                    break
                }
            }
        }
        return isExists
    }
    
    func addColumn(tableName:String,name:String,type:String = "TEXT") async throws{
        try await self.autoExecute {  db in
            try db.executeUpdate("ALTER TABLE \(tableName) ADD COLUMN \(name) \(type)", values: nil)
        }
    }
    
    func columnType(tableName:String,columnName: String) async throws -> String? {
        var columnType: String?
        try await self.autoExecute { db in
            let sql = "PRAGMA table_info(\(tableName))"
            let resultSet = try db.executeQuery(sql, values: nil)
            while resultSet.next() {
                if let existingColumnName = resultSet.string(forColumn: "name"),
                   existingColumnName == columnName {
                    columnType = resultSet.string(forColumn: "type")
                    break
                }
            }
        }
        return columnType
    }
}

public extension FMDatabase{
    func select(tableName:String,predicate:String) async throws->FMResultSet{
        var resultSet:FMResultSet!
        try await self.autoExecute { db in
            resultSet = try  db.executeQuery("SELECT * FROM \(tableName) WHERE \(predicate)", values: nil)
        }
        return resultSet
    }
    
    func isHave(tableName:String,predicate:String) async throws->Bool{
        var isExists = false
        try await self.autoExecute { db in
            let resultSet = try  db.executeQuery("SELECT * FROM \(tableName) WHERE \(predicate)", values: nil)
            isExists = resultSet.next()
        }
        return isExists
    }
   func setValuesForKeys(_ keyedValues: [String : SqlValueProtocol],tableName:String) async throws {
       var keyedValues = keyedValues
       keyedValues["modificationDate"] = Date()
       for (key, value) in keyedValues {
           if try await isColumn(tableName: tableName, columnName: key) == false {
               try await addColumn(tableName: tableName, name: key, type: value.sqltype)
           }
           
           let columnType = try await columnType(tableName: tableName, columnName: key)
           if columnType != value.sqltype {
               throw ISqliteError.sqlColumnTypeError
           }
          
       }
       let keys = keyedValues.map { (key: String, value: SqlValueProtocol) in
           return key
       }
       let keysStr = keys.joined(separator: ",")
       let valeustr = keys.map { item in
           return ":"+item
       }.joined(separator: ",")
       try await self.autoExecute { db in
           let sql = "INSERT OR REPLACE INTO \(tableName) (\(keysStr)) VALUES (\(valeustr))"
           if db.executeUpdate(sql, withParameterDictionary: keyedValues) == false{
               debugPrint(self.lastError())
               throw ISqliteError.sqlUpdateError
           }
       }
    }
    
}


