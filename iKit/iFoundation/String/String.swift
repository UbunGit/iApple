//
//  Optional.swift
//  AEXML
//
//  Created by mac on 2023/3/8.
//

import Foundation

/**
 数值
 */
public extension String{
    func i_double(_ defual:Double = 0) -> Double{
        return Double(self) ?? defual
    }
    func i_doubleValue() -> Double?{
        return Double(self)
    }
    func i_range(of:String)->NSRange{
        let s = self as NSString
        return s.range(of: of)
    }
    
    func i_replacing(str:String, to:String) -> String{
        let s = self as NSString
        return s.replacingOccurrences(of: str, with: to)
    }
    func i_appendPath(_ path:String)->String{
        return self+"/"+path
    }
     
}


/**
 字符串转换
 驼峰转下划线
 下划线转驼峰
 */
public extension String{
    // 驼峰转下划线
    func camelToSnake() -> String {
        let input = self
        let pattern = "([a-z0-9])([A-Z])"
        let regex = try! NSRegularExpression(pattern: input)
        let range = NSRange(location: 0, length: input.utf16.count)
        var output = regex.stringByReplacingMatches(in: input, options: [], range: range, withTemplate: "$1_$2")
        output = output.lowercased()
        return output
    }
    // 下划线转驼峰
    func snakeToCamel() -> String {
        let input = self
        let components = input.components(separatedBy: "_")
        let camelCase = components.map { $0.capitalized }.joined()
        let firstChar = String(camelCase.prefix(1)).lowercased()
        let otherChars = String(camelCase.dropFirst())
        return firstChar + otherChars
    }
}

/**
 媒体
 */
public extension String{
    
    var mediaKind:URL.MeidaKind?{
        URL.init(string: self)?.mediaKind
    }
}
