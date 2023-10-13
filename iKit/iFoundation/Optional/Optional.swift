//
//  Optional.swift
//  AEXML
//
//  Created by mac on 2023/3/8.
//

import Foundation
public extension Optional{

    func i_double(_ defual:Double = 0) -> Double {
        switch self {
        case .some(let value as Double):
            return value
        case .some(let value as String):
            return value.i_double(defual)
        case .some(let value):
            return Double("\(value)") ?? defual
        case .none:
            return defual
        }
    }

    func i_string(_ defual:String = "") -> String {
        switch self {
        case .some(let value as String):
            return value
        case .some(let value as NSString):
            return value as String
        case .some(let value):
            return "\(value)"
        case .none:
            return defual
        }
    }
    
    func i_int(_ defual:Int=0) -> Int {
        guard let value = self else {
            return defual
        }
        guard let value1 = Int("\(value)") else {
            return defual
        }
        return value1
    }
    
    func i_bool(_ defual:Int=0) -> Bool{
        return i_int()>0
    }
    
     
}

