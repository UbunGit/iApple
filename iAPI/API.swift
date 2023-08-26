//
//  UIView.swift
//  Sample
//
//  Created by admin on 2022/11/6.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON




public protocol APIProtocol{
    
}


open class AlamofireAPI:APIProtocol{
    public init(){
        
    }
    public func api_request(url:URL,
                     method:Alamofire.HTTPMethod,
                     header:Alamofire.HTTPHeaders? = nil,
                     params:Parameters? = nil
    )async throws->JSON{

        return try await withUnsafeThrowingContinuation{ continuation in
            let encoding:Alamofire.ParameterEncoding = (method == .post) ? JSONEncoding.default : URLEncoding.default
            AF.request(
                url,
                method: method,
                parameters:params,
                encoding: encoding,
                headers: header)
                .responseData(completionHandler: { response in

                    switch response.result{
                    case .failure(_):
#if DEBUG
                        debugPrint(response)
#endif
                        continuation.resume(throwing: APIError.init(code: -1, msg: "网络连接错误,请检查您的网络"))
                    case .success(let value):
                        var apiResult = APIResult(data: .init(value))
#if DEBUG
                        debugPrint(response)
                        debugPrint(apiResult)
#endif
                        guard let code = apiResult.code else{
                            continuation.resume(throwing: APIError.init(code: -1, msg: "出错了"))
                            return
                        }
                        if code == 0{
                            continuation.resume(returning: apiResult.data)
                        }else{
                            continuation.resume(throwing: APIError.init(code: code, msg: apiResult.message))
                        }
                    }
                })
        }
    }
    
    
    
   
    
    
    
}
