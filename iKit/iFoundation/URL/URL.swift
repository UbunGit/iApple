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

/**
 媒体
 */
extension URL{
    public enum MeidaKind{
        case text
        case pic
        case music
        case video
        case web
    }
    public var mediaKind:MeidaKind{
        let pathExtension = self.pathExtension.lowercased()
        switch pathExtension {
        case "txt", "pdf", "doc", "docx", "rtf":
            return .text
        case "jpg", "jpeg", "png", "gif":
            return .pic
        case "mp3", "wav", "aac":
            return .music
        case "mp4", "mov", "avi":
            return .video
        case "html":
            return .web
        default:
            return .web
        }
    }
}



