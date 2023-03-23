//
//  URL.swift
//  iApple
//
//  Created by mac on 2023/2/25.
//

import Foundation
public extension URL {
    var params: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
    
    var githubUrl:URL{
        let githuburlstr = String(format: "https://ghproxy.com/%@", self.absoluteString)
        return .init(string: githuburlstr)!
    }
}
