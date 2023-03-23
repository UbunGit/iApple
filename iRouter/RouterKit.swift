//
//  RouterKit.swift
//  AFNetworking
//
//  Created by mac on 2022/4/22.
//

import Foundation
import UIKit

extension UIViewController{
    
    public static func i_initWith(urlStr:String)->Self?{
        guard let url = URL(string: urlStr) else{
            return nil
        }
        return Self.i_initWith(url: url)
    }
    
    public static func i_initWith(url:URL)->Self?{
        guard let acls = RouterCenter.share.classWithUrl(url: url) as? NSObject.Type else{
            return nil
        }
        
        let obj = acls.init()
        url.params?.forEach({ (key: String, value: String) in
            obj.setValue(value, forKey: key)
        })
        return obj as? Self
    }
}



