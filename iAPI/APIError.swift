//
//  APIError.swift
//  iApple
//
//  Created by mac on 2023/8/21.
//

import Foundation

public struct APIError:Error{
    public var code:Int
    public var msg:String
    
    public init(code: Int, msg: String) {
        self.code = code
        self.msg = msg
    }

}
extension APIError:LocalizedError{
    public var localizedDescription: String {
        return msg
    }
    public var errorDescription: String? {
        return msg
    }
}
