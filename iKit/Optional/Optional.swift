//
//  Optional.swift
//  AEXML
//
//  Created by mac on 2023/3/8.
//

import Foundation
public extension Optional{
    
    func i_double(_ defual:Double = 0) -> Double {
        guard let value = self else {
            return defual
        }
        guard let value1 = Double("\(value)") else {
            return defual
        }
        return value1
    }

    func i_string(_ defual:String = "") -> String {
        guard let value = self else {
            return defual
        }
      
        return "\(value)"
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

