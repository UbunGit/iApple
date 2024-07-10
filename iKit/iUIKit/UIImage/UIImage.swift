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
        if let image = UIImage.init(named: name){
            return image
        }
        if let image = UIImage.init(systemName: name){
            return image
        }
        return nil
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
    
    func i_circle() -> UIImage{
        //取最短边长
        let shotest = min(self.size.width, self.size.height)
        //输出尺寸
        let outputRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        //开始图片处理上下文（由于输出的图不会进行缩放，所以缩放因子等于屏幕的scale即可）
        UIGraphicsBeginImageContextWithOptions(outputRect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        //添加圆形裁剪区域
        context.addEllipse(in: outputRect)
        context.clip()
        //绘制图片
        self.draw(in: CGRect(x: (shotest-self.size.width)/2,
                             y: (shotest-self.size.height)/2,
                             width: self.size.width,
                             height: self.size.height))
        //获得处理后的图片
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return maskedImage
    }
    
}
