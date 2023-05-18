//
//  CKAsset.swift
//  Alamofire
//
//  Created by mac on 2023/5/15.
//

import Foundation
import CloudKit
import UIKit
extension CKAsset {
    
    public func toImage()-> UIImage? {
        guard let fileURL = self.fileURL else {return nil}
        if let data = self.toData() {
            return UIImage(data: data as Data)
        }
        return nil
    }
    
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
