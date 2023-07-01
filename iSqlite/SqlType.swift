//
//  SqlType.swift
//  Pods
//
//  Created by mac on 2023/7/1.
//

import Foundation
import CloudKit

public protocol SqlValueProtocol:CKRecordValueProtocol {
    var sqltype:String {get}
}
public extension SqlValueProtocol{
  
}

extension Int:SqlValueProtocol{
    public var sqltype:String{
        return "INTEGER"
    }
}
extension Int8:SqlValueProtocol{
    public var sqltype:String{
        return "INTEGER"
    }
}
public extension Int16{
    var sqltype:String{
        return "INTEGER"
    }
}
public extension Int32{
    var sqltype:String{
        return "INTEGER"
    }
}
public extension Int64{
    var sqltype:String{
        return "INTEGER"
    }
}
extension String:SqlValueProtocol{
    public var sqltype:String{
        return "TEXT"
    }
}

extension Bool:SqlValueProtocol{
    public var sqltype:String{
        return "INTEGER"
    }
}
public extension CKAsset{
    var sqltype:String{
        return "BLOB"
    }
}
extension Data:SqlValueProtocol{
    public var sqltype:String{
        return "BLOB"
    }
}

extension Date:SqlValueProtocol{
    public var sqltype:String{
        return "DATE"
    }
}

public extension Double{
    var sqltype:String{
        return "REAL"
    }
}

public extension Float{
    var sqltype:String{
        return "REAL"
    }
}
