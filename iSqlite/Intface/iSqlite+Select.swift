//
//  iSqlite+Select.swift
//  iPods
//
//  Created by admin on 2023/10/14.
//

import Foundation
import FMDB
public extension ISqlManage{
    
    func queryToResultSet(_ sql:String,values:[Any]?)async throws ->FMResultSet{
        return try await withUnsafeThrowingContinuation{ continuation in
            databaseQueue?.inDatabase{ database in
                do{
                    let result = try database.executeQuery(sql,values: values)
                    continuation.resume(returning: result)
                }catch{
                    logging.debug(database.lastError())
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    func queryToResultSet(table: String,
                          column:[String] = ["*"],
                          predicate: String? = nil,
                          orderBy orderList: [String]? = ["modificationDate"],
                          desc:Bool = true,
                          limit: Int? = nil,
                          offset: Int? = nil
    )async throws ->FMResultSet{
        
        var sql = String.init(format: "SELECT %@ FROM %@ ", column.joined(separator: ","),table)
        if let predicate = predicate{
            sql = sql.appending(" WHERE \(predicate) ")
        }
        if let orderList = orderList{
            sql.append(" ORDER BY " + orderList.joined(separator: ","))
            if desc{
                sql.append(" DESC")
            }
        }
        if let limit = limit{
            sql.append("LIMIT \(limit)")
            if let offset = offset{
                sql.append(" OFFSET \(offset)")
            }
        }
        return try await queryToResultSet(sql, values: nil)
        
        
    }
    
    
    func queryOne<T:Decodable>(
        _ type:T.Type,
        table: String,
        column:[String] = ["*"],
        predicate: String? = nil,
        orderBy orderList: [String]? = nil,
        desc:Bool = false) async throws ->T?{
            
            let result = try await queryToResultSet(table: table,column: column,predicate: predicate,orderBy: orderList,desc: desc,limit:1 ,offset: 0)
            var results:[T] = []
            while result.next() {
                let model = try result.toModel(type: T.self)
                results.append(model)
            }
            return results.first
        }
    
    func query(table: String,
               column:[String] = ["*"],
               predicate: String? = nil,
               orderBy orderList: [String]? = ["modificationDate"],
               desc:Bool = true,
               limit: Int? = nil,
               offset: Int? = nil) async throws ->[[String:Sqlable]]{
        let result = try await queryToResultSet(table: table,column: column,predicate: predicate,desc: desc,limit: limit,offset: offset)
        var results:[[String:Sqlable]] = []
        while result.next(){
            if let value = result.resultDictionary as? [String: Sqlable] {
                results.append(value)
            }
        }
        return results
    }
    
    func queryToModels<T:Decodable>(
        _ type: T.Type,
        table: String,
        column:[String] = ["*"],
        predicate: String? = nil,
        orderBy orderList: [String]? = ["modificationDate"],
        desc:Bool = true,
        limit: Int? = nil,
        offset: Int? = nil
    ) async throws ->[T]{
        let result = try await query(table: table,column: column,predicate: predicate,orderBy: orderList,desc: desc,limit: limit,offset: offset)
        return try result.compactMap { item in
            let data = try JSONSerialization.data(withJSONObject: item, options: [])
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        }
    }
    
    
}
