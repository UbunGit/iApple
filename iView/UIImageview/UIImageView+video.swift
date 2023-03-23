//
//  UIImageView+video.swift
//  Alamofire
//
//  Created by mac on 2023/3/23.
//

import Foundation
import SDWebImage
import AVFoundation
extension UIImageView{
   public func videoImag(url:URL,time:Double = 1){
        let cache = SDImageCache.shared
        if let memoryImage = cache .imageFromCache(forKey: url.absoluteString){
            image = memoryImage
            return
        }
        if let diskImage = cache.imageFromDiskCache(forKey: url.absoluteString){
            image = diskImage
            return
        }
        let timeInterval:TimeInterval = .init(floatLiteral: time)
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            let timestamp = CMTime(seconds: timeInterval, preferredTimescale: 60)
          
            DispatchQueue.main.async { [weak self] in
                do {
                    let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil) 
                    let videoImage =  UIImage(cgImage: imageRef)
                    self?.image = videoImage
                    cache.store(videoImage, forKey: url.absoluteString)
                } catch let error {
                    print("Error generating thumbnail: \(error.localizedDescription)")
                }
            }
          
           
        }
    }
}
