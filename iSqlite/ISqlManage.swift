//
//  ISqlManage.swift
//  iApple
//
//  Created by admin on 2023/8/7.
//

import Foundation
import FMDB

open class EncryptDatabaseQueue:FMDatabaseQueue{
    open override class func databaseClass() -> AnyClass {
        return EncryptDatabase.self
    }
}

open class EncryptDatabase:FMDatabase{
    
    open override func open() -> Bool {
        if super.open(){
            if self.setKey("passWord") == false{
                debugPrint(self.lastError())
            }
            return true
        }
        return false
        
    }
    
    open override func open(withFlags flags: Int32, vfs vfsName: String?) -> Bool {
        if super.open(withFlags: flags, vfs: vfsName){
            if self.setKey("passWord") == false{
                debugPrint(self.lastError())
            }
            return true
        }
        return false
    }
}
open class ISqlManage{
   
    var dbpath:String
  
    public lazy var database: FMDatabase = {
        let value = FMDatabase.init(path: dbpath)
        return value
    }()
    
    public  lazy var databaseQueue: FMDatabaseQueue? = {
        let value = FMDatabaseQueue.init(path: dbpath)
        return value
    }()
    
    public init(dbpath: String) {
        
        self.dbpath = dbpath
    }
    
    func isTable(recordType:String) async throws->Bool{
        return try await withUnsafeThrowingContinuation{ continuation in
            databaseQueue?.inDatabase{ database in
                defer{
                    database.commit()
                    database.close()
                  
                }
                var isExists = false
                do{
                    let resultSet = try  database.executeQuery(
                        """
                        SELECT name FROM sqlite_master WHERE type='table' AND name=?
                        """,
                        values: [recordType]
                    )
                    isExists = resultSet.next()
                    resultSet.close()
                    continuation.resume(returning: isExists)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    open func createTable(recordType: String) async throws{
        if try await isTable(recordType: recordType) {
            return
        }
        return try await withUnsafeThrowingContinuation{ continuation in
            databaseQueue?.inDatabase{ database in
                do {
                    let sql = """
                            CREATE TABLE \(recordType) (
                                "uuid" TEXT NOT NULL,
                                "creationDate"  DATE,
                                "modificationDate"    DATE,
                                "isdelete" INTEGER,
                                PRIMARY KEY("uuid")
                            );
                            """
                    try database.executeUpdate(sql, values: nil)
                } catch  {
                    continuation.resume(throwing: error)
                }
                continuation.resume(returning: ())
            }
        }
    }
    
    open func setkeyValues(_ keyvalues: [String : Sqlable], recordType: String) async throws {
        try await createTable(recordType: recordType)
        // 创建列表
        for (key, value) in keyvalues {
            if try await database.isColumn(tableName: recordType, columnName: key) == false {
                try await database.addColumn(tableName: recordType, name: key, type: value.sqltype)
            }
        }
        let columnTypes = try await database.columnTypes(tableName: recordType)
        
        // 重新组装数据
        var sqlDatas:[String:Any] = [:]
        keyvalues.forEach { (key: String, value: Sqlable?) in
            sqlDatas[key] = value?.sqlValue
        }
        if sqlDatas["uuid"] == nil{
            sqlDatas["uuid"] = UUID().uuidString
            sqlDatas["creationDate"] = Date().sqlValue
        }
        sqlDatas["modificationDate"] = Date().sqlValue
        let keys = sqlDatas.compactMap { (key: String, value: Any?) in
            if columnTypes[key] != nil{
                return key
            }
            return nil
        }
        let keysStr = keys.map { item in
            return "'\(item)'"
        }.joined(separator: ",")
        
        let valeustr = keys.map { item in
            return ":"+item
        }.joined(separator: ",")
 
        try await database.autoExecute { db in
            
            let sql = "INSERT OR REPLACE INTO \(recordType) (\(keysStr)) VALUES (\(valeustr))"
            if db.executeUpdate(sql, withParameterDictionary:sqlDatas) == false{
                debugPrint(database.lastError())
                throw ISqliteError.sqlUpdateError
            }
        }
    }
    
    open func delete(uuid: String, recordType: String) async throws ->Bool{
        return try await withUnsafeThrowingContinuation({ continuation in
            databaseQueue?.inDatabase({ database in
                defer{
                    database.commit()
                    database.close()
                }
                do{
                    try database.executeUpdate("""
                    DELETE FROM \(recordType) where uuid=?
                    """,values: [uuid])
                    continuation.resume(returning:true)
                }catch{
                    debugPrint("delete error: \(error)")
                    continuation.resume(throwing: error)
                }
            })
        })
    }
   
    open func fetchToResultSet(table: String,predicate: String? = nil)async throws ->FMResultSet{
        return try await withUnsafeThrowingContinuation({ continuation in
            databaseQueue?.inDatabase({ database in
                
                do{
                    var sql = """
                    select * from \(table)
                    """
                    if let predicate = predicate{
                        sql = sql.appending(" where \(predicate) ")
                    }
                    let result = try database.executeQuery(sql,values: nil)
                    continuation.resume(returning: result)
                }catch{
                    debugPrint(database.lastError())
                    continuation.resume(throwing: error)
                }
            })
        })
    }
    open func fetchToDic(table: String,predicate: String? = nil)async throws ->[[String:Sqlable]]{
        let result = try await fetchToResultSet(table: table,predicate: predicate)
        var results:[[String:Sqlable]] = []
        while result.next(){
            if let value = result.resultDictionary as? [String: Sqlable] {
                results.append(value)
            }
        }
        return results
    }
    
    open func fetchToModels<T:Codable>(_ type: T.Type,table:String,predicate: String? = nil) async throws ->[T]{
        let result = try await fetchToDic(table: table,predicate: predicate)
        return try result.compactMap { item in
            let data = try JSONSerialization.data(withJSONObject: item, options: [])
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        }  
    }
}
open class ISqlEncryptManage:ISqlManage{
    var passWord:String?
    public init(dbpath: String, passWord: String? = nil) {
        super.init(dbpath: dbpath)
#if DEBUG
        self.passWord = passWord
#else
        self.passWord = passWord?.i_md5
#endif
        self.database = EncryptDatabase.init(path: dbpath)
        self.databaseQueue = EncryptDatabaseQueue.init(path: dbpath)
    }
    
}



