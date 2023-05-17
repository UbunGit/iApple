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
        if let data = NSData(contentsOf: fileURL) {
            return UIImage(data: data as Data)
        }
        return nil
    }
}
