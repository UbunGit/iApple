//
//  iSqlite+FMResultSet.swift
//  iPods
//
//  Created by admin on 2023/10/14.
//

import Foundation
import FMDB

public extension FMResultSet{
    
    func toDictionary(handle:((_ key:String,_ resultSet:FMResultSet)->Any?)? = nil) throws ->[String:Any]{
        var dictionary = [String: Any]()
        let num_cols = columnCount
        for columnIdx in 0..<num_cols {
            guard let columnName = columnName(for: columnIdx) else {
                continue
            }
            var objectValue:Any? = nil
            if let handle = handle{
                objectValue = handle(columnName,self)
            }else{
                objectValue = object(forColumnIndex: columnIdx)
            }
            guard let objectValue = objectValue else{
                continue
            }
            dictionary[columnName] = objectValue
        }
        return dictionary
    }

    func toData() throws ->Data{
        guard let dic = self.resultDictionary as? [String:Any] else{
            throw ISqliteError.sqlResultToDataError
        }
        return try dic.toData()
    }
    func toModel<T:Decodable>(type:T.Type) throws ->T{
        let data = try toData()
        return try JSONDecoder().decode(T.self, from: data)
    }
}
