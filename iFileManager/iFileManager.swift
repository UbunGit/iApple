//
//  iFileManager.swift
//  FMDB
//
//  Created by admin on 2023/8/5.
//

import Foundation

public extension FileManager{
    
    static let cloudUrl:URL?
    = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
    
    static let documnetUrl:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static var cloudEnable:Bool{
       return FileManager.default.ubiquityIdentityToken != nil
    }

}
