//
//  APICenter.swift
//  example
//
//  Created by mac on 2023/4/19.
//

import Foundation
import Alamofire
extension Notification.Name{
    static let apiDownDidProgressChange:Notification.Name = .init("apiDownDidProgressChange")
    static let apiDownDidfinesh:Notification.Name = .init("apiDownDidfinesh")
}

protocol APIProtocol{
    

}

extension APIProtocol{
    func down(url:URL,responseBlock:@escaping (AFDownloadResponse<Data>)->()) {
        AF.download(url)
            .downloadProgress { progress in
                debugPrint(progress.fractionCompleted)
                NotificationCenter.default.post(name: .apiDownDidProgressChange,
                                                object:nil,
                                                userInfo: ["key": url.absoluteString,
                                                           "progress":progress
                                                          ])
            }
            .responseData { response in
                NotificationCenter.default.post(name: .apiDownDidfinesh,
                                                object:nil,
                                                userInfo: ["key": url.absoluteString])
                debugPrint(response)
                if let data = response.value {
                    let str = String(data: data, encoding: .utf8)
                    debugPrint(str)
                }
          
                responseBlock(response)
            }
        
    }
}


