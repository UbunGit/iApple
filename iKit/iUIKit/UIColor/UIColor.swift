//
//  UIColor.swift
//  iPods
//
//  Created by mac on 2023/3/2.
//

import Foundation
import SwiftUI
public extension UIColor{
    
  
    
    func i_alpha(_ value:CGFloat) -> UIColor {
        return self.withAlphaComponent(value)
    }
    
 
    func i_hexString() -> String{
        var color = self
        if color.cgColor.numberOfComponents < 4 {
            let components = color.cgColor.components
            color = UIColor(red:components![0], green: components![0], blue: components![0], alpha: components![1])
        }
        
        if color.cgColor.colorSpace?.model != CGColorSpaceModel.rgb{
            return "#FFFFFF"
        }
        guard let components = color.cgColor.components else{
            return "#FFFFFF"
        }
        logging.debug(components)
        
        return String(format: "#%02X%02X%02X%02X",
                      Int(components[0]*255),
                      Int(components[1]*255),
                      Int(components[2]*255),
                      Int(components[3]*255)
        )
    }
 
    ///返回根据当前模式的color
    func i_autoColor(lightColor:UIColor, darkColor:UIColor) -> UIColor {
        if #available(iOS 13.0, *){
            let color = UIColor.init{trainCollection -> UIColor in
                if trainCollection.userInterfaceStyle == UIUserInterfaceStyle.dark{
                    return darkColor
                }else {
                    return lightColor
                }
            }
            return color
        }
        else {
            return lightColor
        }
    }
    // 互补色
    var i_complementary:UIColor{
        let color = self

        // Get the components of the color
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        // Get the complementary color
        return  UIColor(red: 1 - red, green: 1 - green, blue: 1 - blue, alpha: alpha)

        
    }
}



