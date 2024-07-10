//
//  iKit+Float.swift
//  Alamofire
//
//  Created by mac on 2023/6/3.
//

import Foundation
public extension Float {
    // max 最多小数位
     func decimalStr(_ max: Int = 5) -> String {
        let format = NumberFormatter.init()
        format.numberStyle = .decimal
        format.minimumFractionDigits = 0 // 最少小数位
        format.maximumFractionDigits = max // 最多小数位
        format.formatterBehavior = .default
        format.roundingMode = .down // 小数位以截取方式。不同枚举的截取方式不同
        return format.string(from: NSNumber(value: self)) ?? ""
    }
    
    var angle:Float{
       self*Float.pi/180;

    }
    
   
}

public extension CGFloat{
    
    static var i_screenRatio:CGFloat {
        return UIScreen.main.bounds.width/UIScreen.main.bounds.height
    }
    
    var angle:CGFloat{
       self*CGFloat.pi/180;

    }
}


public extension CGFloat{
    var i_auto_w:CGFloat{
        (UIScreen.i_width/375) * self
    }
}
public extension Double{
    var i_auto_w:Double{
        (UIScreen.i_width/375) * self
    }
}
