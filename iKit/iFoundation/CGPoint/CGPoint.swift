//
//  CGSize.swift
//  Alamofire
//
//  Created by mac on 2023/3/23.
//

import Foundation
public
extension CGPoint{
    // 两点间距离
    func distance(to:CGPoint) -> Double{
        let p1 = self
        let p2 = to
        return  sqrt(pow((p1.x - p2.x), 2) + pow((p1.y - p2.y), 2))
    }
}
