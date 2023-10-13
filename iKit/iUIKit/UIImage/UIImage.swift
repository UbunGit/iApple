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




public extension UIImage{
    static func i_image(name:String?) -> UIImage?{
        guard let name = name else{return nil}
        if let image = UIImage.init(systemName: name){
            return image
        }
        return UIImage.init(named: name)
    }
    
    func i_blurEffect() -> UIImage? {
        let context = CIContext(options: nil)
        let inputImage = CIImage(image: self)
        
        // 创建模糊滤镜
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(10, forKey: "inputRadius") // 模糊半径
        
        // 获取模糊后的图像
        guard let outputImage = filter?.outputImage,
              let cgImage = context.createCGImage(outputImage, from: inputImage!.extent) else {
            return nil
        }
        
        return UIImage(cgImage: cgImage)
    }
    
}
