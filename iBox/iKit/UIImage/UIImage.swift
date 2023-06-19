//
//  UIImage.swift
//  Alamofire
//
//  Created by mac on 2023/4/10.
//

import Foundation
import YYCategories
import CloudKit
struct IUIImageExtension:Error{
    var msg:String
}
extension UIImage{
    
    public func save(rootPath:String = UIApplication.shared.documentsPath) throws ->String {
        guard let data = jpegData
        else {
            throw IUIImageExtension.init(msg: "Save error")
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

extension UIImage{
    public var ckAsset:CKAsset?{
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


extension UIImage{
  public  static func i_image(name:String) -> UIImage?{
        if let image = UIImage.init(systemName: name){
            return image
        }
        return UIImage.init(named: name)
    }
}
