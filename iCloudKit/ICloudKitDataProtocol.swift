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


open class ICloudKitObject:NSObject{
    private var _uuid:String? = nil
    var uuid:String{
        return _uuid ?? UUID().uuidString
    }
    open var record:CKRecord{
        fatalError(" Need subclass implementation ")
    }
    // MARK: cloudkit
    static var cloudkitIdentifier:String{
        "iCloud."+(Bundle.main.bundleIdentifier ?? "")
    }
    static var zone:CKRecordZone.ID{
        return .default
    }
    static var container:CKContainer{
        return .init(identifier: cloudkitIdentifier)
    }
    
    class open var recordType: String{
        return NSStringFromClass(self)
    }
    
    class open var database: CKDatabase{
        container.publicCloudDatabase
    }
    
    // MARK:DB
    static var sqlFile: String{
        return "defual.sqlite"
    }
    
    static var sqlPath:URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = documentDirectory.appendingPathComponent("sql")
        if FileManager.default.isExecutableFile(atPath: url.path) == false{
           try! FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        }
        return url.appendingPathComponent("defual.sql")
    }
    
    static var sqlDatabase:FMDatabase {
        let sqlpath = Self.sqlPath
        return FMDatabase(url: sqlpath)
    }
    
    static var sqlTableName:String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public static func createSqlTable() async throws{
        let sql = """
        CREATE TABLE IF NOT EXISTS \(sqlTableName) (
            uuid TEXT PRIMARY KEY NOT NULL,
            recordID TEXT,
            creationDate DATE,
            modificationDate DATE,
            modifiedByDevice TEXT,
            modifiedUser TEXT,
            creatorUser TEXT
        );
        """
      
        try await sqlDatabase.autoExecute { db in
            db.executeStatements(sql)
        }
    }

//    open override func setValuesForKeys(_ keyedValues: [String : Any]) {
//        super.setValuesForKeys(keyedValues)
//        guard let keyedValues = keyedValues as? [String:CKRecordValueProtocol] else{
//            return
//        }
//        Task {
//            do {
//                // 获取当前的记录对象
//                var trecord = record
//                // 更新指定的键值对
//                for (key, value) in keyedValues {
//                    trecord[key] = value
//                }
//                // 保存更新后的记录
//                try await Self.database.save(trecord)
//                
//                try createColumn()
//                
//                try Self.sqlDatabase.autoExecute {
//                    let sql = "INSERT OR REPLACE INTO my_table (key, value, uuid) VALUES (?, ?, ?)"
//                    
//                    for (key, value) in keyedValues {
//                        let uuidValue: String = uuid
//                        let values: [Any] = [key, value, uuidValue]
//                        try Self.sqlDatabase.executeQuery(sql, values: values)
//                    }
//                    
//                    Self.sqlDatabase.commit()
//                }
//            } catch {
//                fatalError("Error:")
//            }
//        }
//        
//    }
//    open override func setValue(_ value: Any?, forKey key: String) {
//        super.setValue(value, forKey: key)
//    
//        guard let value = value as? CKRecordValueProtocol else{
//            return
//        }
//        Task {
//            do {
//                
//                let trecord = record
//                trecord[key] = value
//                try await Self.database.save(trecord)
//                try createColumn()
//                let sql = "INSERT OR REPLACE INTO my_table (key, value) VALUES (?, ?) WHERE uuid=?"
//                try Self.sqlDatabase.autoExecute {
//                    try Self.sqlDatabase.executeQuery(sql, values: [key,value,uuid])
//                }
//            } catch {
//                fatalError("Error :\(self) valueDidchange \(key):\(value)")
//            }
//        }
//    }
//    
  
    open func save() async{
        
        do {
            let db = Self.sqlDatabase
            if try await db.isTable(tableName: Self.sqlTableName) == false{
                try await Self.createSqlTable()
            }
            try await Self.database.save(record)
            let r = record
//            try createColumn(record: r)
            let f = record
            var fields = f.makeIterator()
            while let field = fields.next() {
                let key = field.0
                let value = field.1
                let sql = "INSERT OR REPLACE INTO my_table (key, value) VALUES (?, ?) WHERE uuid=?"
//                try Self.sqlDatabase.autoExecute {  db in
//                    try db.executeQuery(sql, values: [key,value,uuid])
//                }
            }
        } catch {
            fatalError("Error" )
        }
        
    }
}





