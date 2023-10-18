//
//  Sqlable+UIImage.swift
//  iApple
//
//  Created by admin on 2023/10/13.
//

import Foundation
import CloudKit
#if os(iOS)
import UIKit

extension UIImage:Sqlable{
    public var sqltype:String?{
        return "TEXT"
    }
    public var cloudValue: CKRecordValueProtocol {
        return self.ckAsset
    }
    public var sqlValue: String?{
        guard let md5 = self.jpegData?.i_md5 else{
            return nil
        }
        let key = md5.appending(".png")
        let cacheurl = self.i_cacheUrl.appendingPathComponent(key)
        if FileManager.default.fileExists(atPath: cacheurl.path){
            return key
        }
        guard let data = self.pngData() else {
            return nil
        }
        try! data.write(to: cacheurl)
        return key
    }
}
#endif
