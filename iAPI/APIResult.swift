//
//  APIResult.swift
//  iApple
//
//  Created by mac on 2023/8/21.
//

import Foundation
import SwiftyJSON
public protocol APIResultProtocol{
    
    var data: SwiftyJSON.JSON {set get}
    
    init(data: SwiftyJSON.JSON)
}
public struct APIResult:APIResultProtocol{
    
    public var data: SwiftyJSON.JSON
    
    public init(data: SwiftyJSON.JSON) {
        self.data = data
    }
    var code:Int?{
        return data["code"].int
    }
    lazy var result: JSON = {
        return data["data"]
    }()
    lazy var message: String = {
        return data["message"].stringValue
    }()

}
