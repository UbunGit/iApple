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
                logging.debug(self.lastError())
            }
            return true
        }
        return false
        
    }
    
    open override func open(withFlags flags: Int32, vfs vfsName: String?) -> Bool {
        if super.open(withFlags: flags, vfs: vfsName){
            if self.setKey("passWord") == false{
                logging.debug(self.lastError())
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
    
    open func createTable(table: String) async throws{
        if try await isTable(recordType: table) {
            return
        }
        return try await withUnsafeThrowingContinuation{ continuation in
            databaseQueue?.inDatabase{ database in
                do {
                    let sql = """
                            CREATE TABLE \(table) (
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
    @discardableResult
    open func setkeyValues(_ keyvalues: [String : Sqlable], table: String) async throws ->String {
        try await createTable(table: table)
        // 创建列表
        for (key, value) in keyvalues {
            if try await database.isColumn(tableName: table, columnName: key) == false {
                try await database.addColumn(tableName: table, name: key, type: value.sqltype)
            }
        }
        let columnTypes = try await database.columnTypes(tableName: table)
        
        // 重新组装数据
        var sqlData:[String:Any] = [:]
        keyvalues.forEach { (key: String, value: Sqlable?) in
            sqlData[key] = value?.sqlValue
        }
        if sqlData["uuid"] == nil{
            sqlData["uuid"] = UUID().uuidString
            sqlData["creationDate"] = Date().sqlValue
        }
        sqlData["modificationDate"] = Date().sqlValue
        let keys = sqlData.compactMap { (key: String, value: Any?) in
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
            defer{
                database.commit()
                database.close()
            }
            let sql = "INSERT OR REPLACE INTO \(table) (\(keysStr)) VALUES (\(valeustr))"
            if db.executeUpdate(sql, withParameterDictionary:sqlData) == false{
                logging.debug(database.lastError())
                throw ISqliteError.sqlUpdateError
            }
        }
        return sqlData["uuid"].i_string()
    }
    @discardableResult
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
                    logging.debug("delete error: \(error)")
                    continuation.resume(throwing: error)
                }
            })
        })
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



