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
    
    static let documnetUrl:URL? = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    static let documnetpath:String? = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    
    static var cloudEnable:Bool{
       return FileManager.default.ubiquityIdentityToken != nil
    }

}
public extension FileManager{
    func createDirectoryIfNotFound(path:String) throws{
        if(self.fileExists(atPath: path)) == false{
           try self.createDirectory(atPath: path, withIntermediateDirectories: true)
        }
    }
}
