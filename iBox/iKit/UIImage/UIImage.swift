//
//  UIImage.swift
//  Alamofire
//
//  Created by mac on 2023/4/10.
//

import Foundation
import YYCategories
struct IUIImageExtension:Error{
    var msg:String
}
extension UIImage{
    
    public func save(rootPath:String = UIApplication.shared.documentsPath) throws ->String {
        guard let data = jpegData
        else {
            throw IUIImageExtension.init(msg: "保存失败")
        }
        let name = self.defualName
        let imgpath = rootPath.appending("/\(defualName)")
        try data.write(to: .init(fileURLWithPath: imgpath))
        return name
    }
    
    public var jpegData:Data? {
        guard let data = self.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        return data
    }
    public static func image(key:String,rootPath:String = UIApplication.shared.documentsPath)->UIImage?{
  
        let imgpath = rootPath.appending("/\(key)")
        return UIImage.init(contentsOfFile: imgpath)
        
    }
    private var defualName:String{
        guard let md5Str = self.jpegData?.i_md5 else{
            return Date().i_dateString("yyyyMMddHHmmss")+".jpeg"
        }
        return md5Str
    }
    
  
   
    
    
}
