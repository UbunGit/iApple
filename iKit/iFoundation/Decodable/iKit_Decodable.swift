//
//  iKit_Decodable.swift
//  Alamofire
//
//  Created by admin on 2023/11/4.
//

import Foundation

extension Decodable{
    
}

public extension Encodable{
    var i_dictionary:Any?{
        do{
            let data = try JSONEncoder().encode(self)
            return try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed)
        }catch{
            logging.debug(error)
            return nil
        }
        
    }
    
 
}

