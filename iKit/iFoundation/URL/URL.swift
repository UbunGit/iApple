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
    
    func appendParams(_ params:[String: String])->URL?{
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        else { return nil }
        var newQueryItems:[URLQueryItem] = components.queryItems ?? []
        params.forEach { (name, value) in
            newQueryItems.append(.init(name: name, value: value))
        }
        components.queryItems = newQueryItems
        return components.url
    }
    
    var githubUrl:URL{
        let githuburlstr = String(format: "https://ghproxy.com/%@", self.absoluteString)
        return .init(string: githuburlstr)!
    }
}
