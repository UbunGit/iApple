//
//  UIApp.swift
//  GoogleUtilities
//
//  Created by mac on 2023/2/25.
//

import Foundation
import Security

public extension UIApplication{
    @discardableResult
    
    func i_keychain_setValue(_ data:Data, key:String)->Bool{
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]
        SecItemDelete(query as CFDictionary)
        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
        return status == noErr
    }
    
    func i_keychain_value(forKey: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : forKey,
            kSecReturnData as String  : kCFBooleanTrue as Any,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        var dataTypeRef: AnyObject?
        let status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        
        if status == errSecSuccess {
            if let data = dataTypeRef as! Data? {
                return data
            }
        }
        return nil
    }
    
    @discardableResult
    func i_keychain_remove(key: String) -> Bool {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key ] as [String : Any]
        
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        return status == noErr
    }
    
    @discardableResult
    func i_keychain_clear() -> Bool {
        let query = [ kSecClass as String : kSecClassGenericPassword ]
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        return status == noErr
    }
}

