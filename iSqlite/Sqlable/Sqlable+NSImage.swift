//
//  Sqlable+NSImage.swift
//  iPods
//
//  Created by admin on 2023/10/13.
//

import Foundation

#if os(macOS)
import AppKit
extension NSImage:Sqlable{
    public var sqltype:String?{
        return "TEXT"
    }
    public var cloudValue: CKRecordValueProtocol {
        return self.ckAsset
    }
    public var sqlValue: CKRecordValueProtocol?{
        let key = UUID().uuidString.appending(".tff")
        let cacheurl = self.cacheUrl.appendingPathComponent(key)
        guard let data = self.tiffRepresentation else {
            return nil
        }
        try! data.write(to: cacheurl)
        return key
    }
}
#endif
