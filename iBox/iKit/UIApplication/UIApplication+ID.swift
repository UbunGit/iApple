//
//  UIApplication+ID.swift
//  iApple
//
//  Created by mac on 2023/2/25.
//

import Foundation
import AdSupport

let iUUIDKEY="uiapplication.uuid"
// 唯一值
public extension UIApplication{
    
    var i_idfa:String?{
        if  ASIdentifierManager.shared().isAdvertisingTrackingEnabled{
            return ASIdentifierManager.shared().advertisingIdentifier.uuidString
        }else{
            return nil
        }
    }
    
    // udid
    var i_udid:String?{
        
        if let uuidData = UIApplication.shared.i_keychain_value(forKey: iUUIDKEY),
           let uuid = String(data: uuidData, encoding: .utf8)
        {
            return uuid
        }
        guard let uuid = CFUUIDCreate(nil) else {
            return nil
        }
        
        let uuistr = CFUUIDCreateString(nil, uuid)! as String
        guard let uuidData = uuistr.data(using: .utf8) else {
            return nil
        }
        UIApplication.shared.i_keychain_setValue(uuidData, key: iUUIDKEY)
        return uuistr
    }
    // 系统版本
    var i_systemVersion:String{
        return UIDevice.current.systemVersion
        
    }
    
    // 手机型号
   var i_modenName:String{
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
        
    }
    
    var i_appVersion:String{
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    var i_window:UIWindow?{
        return UIApplication.shared.delegate?.window ?? nil
    }
   
}
