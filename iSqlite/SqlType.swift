//
//  SqlType.swift
//  Pods
//
//  Created by mac on 2023/7/1.
//

import Foundation
import CloudKit

public protocol SqlValueProtocol:CKRecordValueProtocol {
    var sqltype:String? {get}
}
public extension SqlValueProtocol{
  
}

extension Optional: SqlValueProtocol{
    public var sqltype: String? {
        switch self {
        
        case .some(let value as SqlValueProtocol):
            return value.sqltype
        case .some(_):
            return "TEXT"
        case .none:
            return nil
      
        }
    }
}


extension Int:SqlValueProtocol{
    public var sqltype:String?{
        return "INTEGER"
    }
}
extension Int8:SqlValueProtocol{
    public var sqltype:String?{
        return "INTEGER"
    }
}
public extension Int16{
    var sqltype:String?{
        return "INTEGER"
    }
}
public extension Int32{
    var sqltype:String?{
        return "INTEGER"
    }
}
extension Int64:SqlValueProtocol{
    public var sqltype:String?{
        return "INTEGER"
    }
}
extension String:SqlValueProtocol{
    public var sqltype:String?{
        return "TEXT"
    }
}

extension Bool:SqlValueProtocol{
    public var sqltype:String?{
        return "INTEGER"
    }
}
extension CKAsset:SqlValueProtocol{
    public var sqltype:String?{
        return "BLOB"
    }
}
extension Data:SqlValueProtocol{
    public var sqltype:String?{
        return "BLOB"
    }
}

extension Date:SqlValueProtocol{
    public var sqltype:String?{
        return "DATE"
    }
}
extension UIImage:SqlValueProtocol{
    public var sqltype:String?{
        return "BLOB"
    }
}

extension Double:SqlValueProtocol{
    public var sqltype:String?{
        return "FLOAT"
    }
}

extension Float:SqlValueProtocol{
    public var sqltype:String?{
        return "FLOAT"
    }
}
extension NSNumber:SqlValueProtocol{
    public var sqltype:String?{
        return "FLOAT"
    }
}
extension NSString:SqlValueProtocol{
    public var sqltype:String?{
        return "TEXT"
    }
}
extension NSNull:SqlValueProtocol{
    public var sqltype:String?{
        return "NULL"
    }
}

//#define SQLITE_INTEGER  1
//#define SQLITE_FLOAT    2
//#define SQLITE_BLOB     4
//#define SQLITE_NULL     5
//# undef SQLITE_TEXT



