//
//  CKR+.swift
//  iPods
//
//  Created by mac on 2023/7/4.
//

import Foundation
import CloudKit
#if os(macOS)
import AppKit
#else
import UIKit
#endif

public extension CKRecord{
    func value<T:Any>(forColumn column:String)->T?{
        guard let value = self[column] as? T else{
            return nil
        }
        return value
    }
    
    func int(forColumn column:String)->Int{
        if let value:Int = self.value(forColumn: column){
            return value
        }
        return 0
    }
    
    func string(forColumn column:String)->String{
        if let value:String = self.value(forColumn: column){
            return value
        }
        return ""
    }
#if os(iOS)
    func image(forColumn column:String)->UIImage?{
        guard let value = self[column] as? CKAsset else{
            return nil
        }
        return value.toImage()
    }
#endif
#if os(macOS)
    func image(forColumn column:String)->NSImage?{
        guard let value = self[column] as? CKAsset else{
            return nil
        }
        return value.toImage()
    }
#endif
    
}
