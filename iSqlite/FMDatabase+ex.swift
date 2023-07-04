//
//  AppDelegate.swift
//  iTest
//
//  Created by mac on 2023/6/9.
//


import FMDB
enum ISqliteError:Error{
    case sqlOpenError
    case tableDoesNotExist
    case sqlColumnTypeError
    case sqlUpdateError
}
public extension FMDatabase{
    
    func autoQuery(_ block: (_ db:FMDatabase)async throws -> FMResultSet) async throws ->FMResultSet{
        guard self.open() else {
            throw ISqliteError.sqlOpenError
        }
        
        do {
            return try await block(self)
        } catch {
            // 处理异常
            throw error
        }
    }
   
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
    
    func addColumn(tableName:String,name:String,type:String?) async throws{
        guard let type = type else {return}
        try await self.autoExecute {  db in
            let sql = "ALTER TABLE \(tableName) ADD COLUMN '\(name)' \(type)"
            try db.executeUpdate(sql, values: nil)
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
    func columnTypes(tableName:String) async throws -> [String:String?] {
        var columnTypes:[String:String?] = [:]
        try await self.autoExecute { db in
            let sql = "PRAGMA table_info(\(tableName))"
            let resultSet = try db.executeQuery(sql, values: nil)
            while resultSet.next() {
                if let existingColumnName = resultSet.string(forColumn: "name") {
                    columnTypes[existingColumnName] = resultSet.string(forColumn: "type")
                }
            }
        }
        return columnTypes
    }
}

public extension FMDatabase{
    func fetch(tableName:String,predicate:String?) async throws->FMResultSet{
        
        let resultSet = try await self.autoQuery { db in
            let sql = "SELECT * FROM \(tableName) " + ((predicate == nil) ? "" : .init(format: " WHERE %@ ", predicate!))
            let resultSet = try db.executeQuery(sql, values: nil)
            return resultSet
        }
        return resultSet
    }
    func delete(tableName:String,predicate:String?) async throws{
        
        try await self.autoExecute { db in
            let sql = "DELETE FROM \(tableName) " + ((predicate == nil) ? "" : .init(format: " WHERE %@ ", predicate!))
            return try db.executeUpdate(sql, values: nil)
        }
       
    }
    
    func isHave(tableName:String,predicate:String) async throws->Bool{
        var isExists = false
        try await self.autoExecute { db in
            let resultSet = try  db.executeQuery("SELECT * FROM \(tableName) WHERE \(predicate)", values: nil)
            isExists = resultSet.next()
        }
        return isExists
    }
    
   
  
}

