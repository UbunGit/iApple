//
//  CKAsset.swift
//  Alamofire
//
//  Created by mac on 2023/5/15.
//

import Foundation
import CloudKit

#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension CKAsset {
#if os(iOS)
    public func toImage()-> UIImage? {
        if let data = self.toData() {
            return UIImage(data: data as Data)
        }
        return nil
    }
#endif
#if os(macOS)
    public func toImage()-> NSImage? {
        if let data = self.toData() {
            return NSImage(data: data as Data)
        }
        return nil
    }
#endif
    public func toData()-> Data? {
        guard let fileURL = self.fileURL else {return nil}
        do {
            let data =  try Data(contentsOf: fileURL)
            return data
        } catch  {
            return nil
        }
    }
}
#if os(iOS)
public extension UIImage{
    var ckAsset:CKAsset?{
        if let avatarData = self.pngData(),
           let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString+".dat"){
            
            do {
                try avatarData.write(to: url)
                return CKAsset(fileURL: url)
            } catch {
                print("UIImage to ckAsset! \(error)");
                return nil
            }
        }else{
            return nil
        }
    }
}

public extension NSData{
    var ckAsset:CKAsset?{
        
        if let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString+".dat"){
            
            do {
                try self.write(to: url)
                return CKAsset(fileURL: url)
            } catch {
                print("UIImage to ckAsset! \(error)");
                return nil
            }
        }else{
            return nil
        }
    }
}
public extension Data{
    var ckAsset:CKAsset?{
        
        if let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString+".dat"){
            
            do {
                try self.write(to: url)
                return CKAsset(fileURL: url)
            } catch {
                print("UIImage to ckAsset! \(error)");
                return nil
            }
        }else{
            return nil
        }
    }
    
}
#endif
#if os(macOS)
public extension NSImage {
    var ckAsset: CKAsset? {
        guard let avatarData = self.tiffRepresentation else {
            return nil
        }
        
        do {
            let fileManager = FileManager.default
            let temporaryDirectory = fileManager.temporaryDirectory
            let filename = UUID().uuidString + ".dat"
            let fileURL = temporaryDirectory.appendingPathComponent(filename)
            
            try avatarData.write(to: fileURL)
            return CKAsset(fileURL: fileURL)
        } catch {
            print("NSImage to ckAsset! \(error)")
            return nil
        }
    }
}
public extension Data{
    var ckAsset:CKAsset?{
        
        do {
            let fileManager = FileManager.default
            let temporaryDirectory = fileManager.temporaryDirectory
            let filename = UUID().uuidString + ".dat"
            let fileURL = temporaryDirectory.appendingPathComponent(filename)
            
            try self.write(to: fileURL)
            return CKAsset(fileURL: fileURL)
        } catch {
            print("NSImage to ckAsset! \(error)")
            return nil
        }
    }
}

public extension NSData{
    var ckAsset:CKAsset?{
        
        do {
            let fileManager = FileManager.default
            let temporaryDirectory = fileManager.temporaryDirectory
            let filename = UUID().uuidString + ".dat"
            let fileURL = temporaryDirectory.appendingPathComponent(filename)
            
            try self.write(to: fileURL)
            return CKAsset(fileURL: fileURL)
        } catch {
            print("NSImage to ckAsset! \(error)")
            return nil
        }
    }
}
#endif


extension CKAsset:SqlValueProtocol{
    public var sqltype:String?{
        return "BLOB"
    }
    public var cloudKitData: CKRecordValueProtocol {
        return self
    }
    public var sqlData: CKRecordValueProtocol?{
        return self.toData()
    }
}


