//
//  CGSize.swift
//  Alamofire
//
//  Created by mac on 2023/3/23.
//

import Foundation
extension CGSize{
    
    func auto(towidth:CGFloat)->CGSize{
        if self.width*towidth*height==0{
            return .zero
        }
        let h = height*towidth/width
        return .init(width: towidth, height: h)
    }
    
    func auto(toheight:CGFloat)->CGSize{
        if self.width*toheight*height==0{
            return .zero
        }
        let w = width*toheight/height
        return .init(width: w, height: toheight)
    }
}
