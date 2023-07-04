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


open class ICloudSqlObject{
    
    var keyValues:[String:SqlValueProtocol] = [:]
    
    public init(keyValues:[String:SqlValueProtocol]) {
        self.keyValues = keyValues
    }
    public var uuid:String{
        return keyValues["uuid"] as! String
    }
}



extension FMDatabase{
    
    func setkeysValues(_ keyValues: [String : SqlValueProtocol?],tableName:String) async throws {

        for (key, value) in keyValues {
            if try await isColumn(tableName: tableName, columnName: key) == false {
                try await addColumn(tableName: tableName, name: key, type: value.sqltype)
            }
           
        }
        let columnTypes = try await columnTypes(tableName: tableName)
        let keys = keyValues.compactMap { (key: String, value: SqlValueProtocol?) in
            if columnTypes[key] != nil{
                return key
            }
            return nil
        }
        
        let keysStr = keys.joined(separator: ",")
        let valeustr = keys.map { item in
            return ":"+item
        }.joined(separator: ",")
        try await self.autoExecute { db in
            let sql = "INSERT OR REPLACE INTO \(tableName) (\(keysStr)) VALUES (\(valeustr))"
            if db.executeUpdate(sql, withParameterDictionary: keyValues as [AnyHashable : Any]) == false{
                debugPrint(self.lastError())
                throw ISqliteError.sqlUpdateError
            }
        }
    }
    
    func lastModificationDate(tableName:String)async throws ->Date?{
        var lastModificationDate:Date? = nil
        let sql = "SELECT MAX(modificationDate) as max FROM \(tableName)"
        try await autoExecute { db in
            let resultSet = try db.executeQuery(sql, values: nil)
            guard resultSet.next() else { return }
            lastModificationDate = resultSet.date(forColumn: "max")
        }
        return lastModificationDate
    }
    
    
}

extension FMResultSet{
    
}
enum ICloudKitError:Error{
    case sqlUpdateUUIDISNULL
    case sqlUpdateDataISNULL
}

public class CloudSqlQuery:NSObject{
    var recordType:String
    
    public init(recordType: String) {
        self.recordType = recordType
        
    }
    // MARK:DB
    static var sqlFile: String{
        return "defual.sqlite"
    }
    
    var sqlPath:URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = documentDirectory.appendingPathComponent("sql")
        if FileManager.default.isExecutableFile(atPath: url.path) == false{
            try! FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        }
        return url.appendingPathComponent("defual.sql")
    }
    
    var sqlDatabase:FMDatabase {
        return FMDatabase(url: sqlPath)
    }
    
    func setUp()async throws{
        try await createTable()
    }
    
    private func createTable() async throws{
        
        let sql = """
            CREATE TABLE IF NOT EXISTS \(recordType) (
                uuid TEXT PRIMARY KEY NOT NULL,
                recordID TEXT,
                creationDate DATE,
                modificationDate DATE,
                asyncDate DATE,
                modifiedByDevice TEXT,
                modifiedUser TEXT,
                creatorUser TEXT,
                isdelete INTEGER
            );
            """
        try await sqlDatabase.autoExecute { db in
            db.executeStatements(sql)
        }
        
    }
    
    // 增
    public func add(keyvalues:[String:SqlValueProtocol]) async throws{
        try await setUp()
        if keyvalues["uuid"] != nil {
          try await update(keyvalues: keyvalues)
            
        }else{
            var keyvalues = keyvalues
            keyvalues["uuid"] = UUID().uuidString
            keyvalues["creationDate"] = Date()
            keyvalues["modificationDate"] = Date()
            try await sqlDatabase.setkeysValues(keyvalues, tableName: recordType)
        }
    }
    
    // 删
    
    public func delete(uuid:String) async throws{
        try await setUp()
        let keyvalues = [
            "uuid":uuid,
            "isdelete":1
        ] as [String : SqlValueProtocol]
        try await update(keyvalues: keyvalues)
    }
    
    // 改
    public  func update(keyvalues:[String:SqlValueProtocol]) async throws{
        try await setUp()
        guard let uuid = keyvalues["uuid"] as? String else{
            throw ICloudKitError.sqlUpdateUUIDISNULL
        }
        let predicate = String.init(format: " uuid = '%@' ", uuid)
        let result = try await sqlDatabase.fetch(tableName: recordType, predicate: predicate)
        var results:[[AnyHashable : Any]] = []
        while result.next() {
            if let data = result.resultDictionary{
                results.append(data)
            }
        }
        guard var updateKeyvales = results.first else{
            throw ICloudKitError.sqlUpdateDataISNULL
        }
        updateKeyvales["creationDate"] = Date()
        updateKeyvales["modificationDate"] = Date()
        updateKeyvales["asyncDate"] = nil
        keyvalues.forEach { (key: String, value: SqlValueProtocol) in
            updateKeyvales[key] = value
        }
        try await sqlDatabase.setkeysValues(keyvalues, tableName: recordType)
    }
    
    // 查
    public func fetch(predicate:String?) async throws ->[[String:SqlValueProtocol]]{
        try await setUp()
        let predicate = predicate ?? "" + ((predicate==nil) ? "isdelete is not 1 " : " and isdelete is not 1 ")
        let result = try await sqlDatabase.fetch(tableName: recordType, predicate: predicate)
        var results:[[String : SqlValueProtocol]] = []
        while result.next() {
            var r: [String: SqlValueProtocol] = [:]
            
            if let value = result.resultDictionary as? [String: Any] {
                for (key, value) in value {
                    debugPrint(key)
                    debugPrint(value)
                    let v = value as! SqlValueProtocol
                    r[key] = v
                }
            }
            results.append(r)
        }
        
        return results
        
    }
    
    public func pull()async throws
}





