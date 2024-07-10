//
//  SqlableFloat.swift
//  iPods
//
//  Created by admin on 2023/10/13.
//

import Foundation
import CloudKit
extension Float:Sqlable{
    public var sqltype:String?{
        return "FLOAT"
    }
}
