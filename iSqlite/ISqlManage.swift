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
    var passWord:String?
    public lazy var database: EncryptDatabase = {
        let value = EncryptDatabase.init(path: dbpath)
        return value
    }()
    
    public  lazy var databaseQueue: EncryptDatabaseQueue? = {
        let value = EncryptDatabaseQueue.init(path: dbpath)
        return value
    }()
    
    public init(dbpath: String, passWord: String? = nil) {
        self.dbpath = dbpath
#if DEBUG
        self.passWord = passWord
#else
        self.passWord = passWord?.i_md5
#endif
        
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
    
    open  func setkeyValues(_ keyvalues: [String : SqlValueProtocol], recordType: String) async throws {
        
        // 创建列表
        for (key, value) in keyvalues {
            if try await database.isColumn(tableName: recordType, columnName: key) == false {
                try await database.addColumn(tableName: recordType, name: key, type: value.sqltype)
            }
        }
        let columnTypes = try await database.columnTypes(tableName: recordType)
        
        // 重新组装数据
        var sqlDatas:[String:Any] = [:]
        keyvalues.forEach { (key: String, value: SqlValueProtocol?) in
            sqlDatas[key] = value?.sqlData
        }
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
                    DELETE FROM \(recordType) where uuid=? "
                    """,values: [uuid])
                }catch{
                    continuation.resume(throwing: error)
                }
            })
        })
    }
   
    
    open func fetchToDic(recordType: String,predicate: String? = nil)async throws ->[[String:SqlValueProtocol]]{
        return try await withUnsafeThrowingContinuation({ continuation in
            databaseQueue?.inDatabase({ database in
                defer{
                    database.commit()
                    database.close()
                }
                var results:[[String:SqlValueProtocol]] = []
                do{
                    let result = try database.executeQuery("""
                    select * from \(recordType)
                    """,values: nil)
                    while result.next(){
                        if let value = result.resultDictionary as? [String: SqlValueProtocol] {
                            results.append(value)
                        }
                    }
                    continuation.resume(returning: results)
                }catch{
                    debugPrint(database.lastError())
                    continuation.resume(throwing: error)
                }
            })
        })
    }
    
}



