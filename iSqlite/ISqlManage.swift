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
    
    open func createTable(recordType: String) async throws{
        
    }
    
    open  func add(keyvalues: [String : SqlValueProtocol], recordType: String) async throws {
    }
    
    open func delete(uuid: String, recordType: String) async throws {
    }
    
    open func update(keyvalues: [String : SqlValueProtocol], recordType: String) async throws{
        
    }
    
    open func fetchToDic(recordType: String,predicate: String? = nil)async throws ->[[String:SqlValueProtocol]]{
        return []
    }
    
}



