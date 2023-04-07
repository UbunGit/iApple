//
//  URL.swift
//  Alamofire
//
//  Created by mac on 2023/4/7.
//

import Foundation
extension URL{
    public static var i_randomImageURL:URL{
        let url = URL.init(string: "https://picsum.photos/600?id=\(UInt32.random(in: UInt32.min...UInt32.max))")!
        return url
    }
}
