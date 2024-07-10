//
//  iKit_Decodable.swift
//  Alamofire
//
//  Created by admin on 2023/11/4.
//

import Foundation
public extension Dictionary where Key == String {
    func toData() throws ->Data{
        return try JSONSerialization.data(withJSONObject:self, options: [])
    }
    func toModel<T:Decodable>(type:T.Type) throws ->T{
        let data = try toData()
        return try JSONDecoder().decode(T.self, from: data)
    }
}

public
extension Dictionary where Key == String{
    
    
    static func contentsOf(url:URL)->Dictionary?{
        do{
            let fileData = try Data(contentsOf: url)
            let jsonObject = try JSONSerialization.jsonObject(with: fileData, options: [])
            guard let dictionary = jsonObject as? NSDictionary else{
                return nil
            }
            let dic =  dictionary as? Dictionary
            return dic
            
        }catch{
            debugPrint(error)
            return nil
        }
    }
    
    func containsObjectForKey(_ key:String)->Bool{
        return self.keys.contains(key)
    }
    
    func data()->Data?{
        do {
            let decoder = JSONDecoder()
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch  {
            debugPrint(error)
            return nil
        }
    }
    
    func toModel<T:Decodable>(type:T.Type)->T?{
        do {
            guard let data = self.data() else {return nil}
            return try JSONDecoder().decode(T.self, from: data)
        } catch  {
            debugPrint(error)
            return nil
        }
    }
    func stringValue(_ key:String)->String?{
        return self[key] as? String
    }
    
    func string(_ key:String, def:String)->String{
        
        guard let value = self[key] else { return def }
        if value is NSNull { return def }
        if let stringValue = value as? String { return stringValue }
        if let numberValue = value as? NSNumber { return numberValue.description }
        return def
    }
    
    func intValue(_ key: String) -> Int? {
        return self[key] as? Int
    }
    
    func int(_ key: String, default def: Int) -> Int {
        guard let value = self[key] else { return def }
        if value is NSNull { return def }
        if let intValue = value as? Int { return intValue }
        if let numberValue = value as? NSNumber { return numberValue.intValue }
        return def
    }
    
    func floatValue(_ key: String) -> Float? {
        return self[key] as? Float
    }
    
    func float(_ key: String, default def: Float) -> Float {
        guard let value = self[key] else { return def }
        if value is NSNull { return def }
        if let floatValue = value as? Float { return floatValue }
        if let numberValue = value as? NSNumber { return numberValue.floatValue }
        return def
    }
    
    // double
    
    func doubleValue(_ key: String) -> Double? {
        return self[key] as? Double
    }
    func double(_ key: String, default def: Double) -> Double {
        guard let value = self[key] else { return def }
        if value is NSNull { return def }
        if let doubleValue = value as? Double { return doubleValue }
        if let numberValue = value as? NSNumber { return numberValue.doubleValue }
        return def
    }
    
    // number
    
    func numberValue(_ key: String) -> NSNumber? {
        return self[key] as? NSNumber
    }
    
    func number(_ key: String, default def: NSNumber) -> NSNumber {
        guard let value = self[key] else { return def }
        if value is NSNull { return def }
        if let numberValue = value as? NSNumber { return numberValue }
        return def
    }
    
    // bool
    
    func boolValue(_ key: String) -> Bool? {
        return self[key] as? Bool
    }
    
    func bool(_ key: String, default def: Bool) -> Bool {
        guard let value = self[key] else { return def }
        if value is NSNull { return def }
        if let boolValue = value as? Bool { return boolValue }
        if let numberValue = value as? NSNumber { return numberValue.boolValue }
        return def
    }
}

public extension NSCoder {
    func stringValue(_ key: String) -> String? {
        return self.decodeObject(forKey: key) as? String
    }
    
    func string(_ key: String, def: String) -> String {
        guard let value = self.decodeObject(forKey: key) else { return def }
        if value is NSNull { return def }
        if let stringValue = value as? String { return stringValue }
        if let numberValue = value as? NSNumber { return numberValue.description }
        return def
    }
    
    func intValue(_ key: String) -> Int? {
        return self.decodeObject(forKey: key) as? Int
    }
    
    func int(_ key: String, default def: Int) -> Int {
        guard let value = self.decodeObject(forKey: key) else { return def }
        if value is NSNull { return def }
        if let intValue = value as? Int { return intValue }
        if let numberValue = value as? NSNumber { return numberValue.intValue }
        return def
    }
    
    func floatValue(_ key: String) -> Float? {
        return self.decodeObject(forKey: key) as? Float
    }
    
    func float(_ key: String, default def: Float) -> Float {
        guard let value = self.decodeObject(forKey: key) else { return def }
        if value is NSNull { return def }
        if let floatValue = value as? Float { return floatValue }
        if let numberValue = value as? NSNumber { return numberValue.floatValue }
        return def
    }
    
    func doubleValue(_ key: String) -> Double? {
        return self.decodeObject(forKey: key) as? Double
    }
    
    func double(_ key: String, default def: Double) -> Double {
        guard let value = self.decodeObject(forKey: key) else { return def }
        if value is NSNull { return def }
        if let doubleValue = value as? Double { return doubleValue }
        if let numberValue = value as? NSNumber { return numberValue.doubleValue }
        return def
    }
    
    func numberValue(_ key: String) -> NSNumber? {
        return self.decodeObject(forKey: key) as? NSNumber
    }
    
    func number(_ key: String, default def: NSNumber) -> NSNumber {
        guard let value = self.decodeObject(forKey: key) else { return def }
        if value is NSNull { return def }
        if let numberValue = value as? NSNumber { return numberValue }
        return def
    }
    
    func boolValue(_ key: String) -> Bool? {
        return self.decodeObject(forKey: key) as? Bool
    }
    
    func bool(_ key: String, default def: Bool) -> Bool {
        guard let value = self.decodeObject(forKey: key) else { return def }
        if value is NSNull { return def }
        if let boolValue = value as? Bool { return boolValue }
        if let numberValue = value as? NSNumber { return numberValue.boolValue }
        return def
    }
}


public extension KeyedDecodingContainer {
    
    
    func string(forKey key: K, default def: String)throws ->String{
        if let value = try? self.decode(String.self, forKey: key) {
            return value
        } else if let value = try? self.decode(Int.self, forKey: key) {
            return String(value)
        } else if let value = try? self.decode(Double.self, forKey: key) {
            return String(value)
        } else if let value = try? self.decode(Bool.self, forKey: key) {
            return String(value)
        } else {
            return def
        }
    }
    
}


public extension Dictionary where Key == String{
    /**
     实现 self[key1.key2.ke3] = updateBlock:(_ value:Any)->(Any))
     */
    func updateValue(keyPath: String, updateBlock:(_ value:Any)->(Any))throws ->[String:Any] {
        if keyPath.count<=0 { return self}
        let components = keyPath.components(separatedBy: ".")
        
        var result:[String:Any] = [:]
        for key in self.keys{
            if key == components.first,
               let value = self[key]
            {
                
                if key == components.last{
                    result[key] = updateBlock(value)
                }else{
                    let newkeypath = components[1...].joined(separator: ".")
                    if let item = value as? [String:Any]{
                        result[key] = try item.updateValue(keyPath: newkeypath, updateBlock: updateBlock)
                    }else if let item = value  as?  [[String:Any]]{
                        result[key] = item.map({ i in
                            try! i.updateValue(keyPath: newkeypath, updateBlock: updateBlock)
                        })
                    }else{
                        result[key] = self[key]
                    }
                }
                
                
            }else{
                result[key] = self[key]
            }
        }
        return result
    }
}
