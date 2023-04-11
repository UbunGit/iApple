//
//  UIImage.swift
//  Alamofire
//
//  Created by mac on 2023/4/10.
//

import Foundation
extension UIImage{
    public func save(path:URL) throws {
        guard let data = self.jpegData(compressionQuality: 1.0) else {
             return
         }
        try data.write(to: path)
    }
 
}
