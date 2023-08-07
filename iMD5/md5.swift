//
//  md5.swift
//  iBluetooth
//
//  Created by mac on 2023/2/22.
//

import Foundation
import CryptoKit

public extension String {
    var i_md5: String? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        let digest = Insecure.MD5.hash(data: data)
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

public extension URL{
    var i_md5: String? {
        guard let data = try? Data.init(contentsOf: self)  else {
            return nil
        }
        let digest = Insecure.MD5.hash(data:data)
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
public extension Data{
    
    var i_md5: String? {
        let digest = Insecure.MD5.hash(data:self)
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

