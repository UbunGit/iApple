//
//  CKR+.swift
//  iApple
//
//  Created by mac on 2023/7/4.
//

import Foundation
import CloudKit
import UIKit

public extension CKRecord{
    func value<T:Any>(forColumn column:String)->T?{
        guard let value = self[column] as? T else{
            return nil
        }
        return value
    }
    
    func string(forColumn column:String)->String{
        if let value:String = self.value(forColumn: column){
            return value
        }
        return ""
    }
    
    func image(forColumn column:String)->UIImage?{
        guard let value = self[column] as? CKAsset else{
            return nil
        }
        return value.toImage()
    }
    
    func int(forColumn column:String)->Int{
        if let value:Int = self.value(forColumn: column){
            return value
        }
        return 0
    }
}
