//
//  ThumbnailUrl.swift
//  iApple
//
//  Created by mac on 2023/4/19.
//

import Foundation
import SDWebImage
extension URL{
    
    func thumbnailUrl(){
        let pathExtension = self.pathExtension // "png"
        switch pathExtension{
            case "m3u8":
            break
        }
    }
}
