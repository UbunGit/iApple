//
//  TrendsData.swift
//  Trends
//
//  Created by mac on 2023/7/14.
//

import Foundation

final class TrendsData:ObservableObject,Identifiable{
    var member:Member!
    var content:String? = nil
    var images:[URL] = []
}
extension TrendsData:Mock{
    public class func mock() -> TrendsData {
        let data = TrendsData()
        data.member = .mock()
        data.content = .i_random_zh(count: Int.random(in: (20...200)))
        data.images = (0..<Int.random(in: (0...12))).map({ index in
                .i_randomImgUrl(size: .init(width: 120, height: 120), id: "\(index)")
        })
//        data.images = (0..<5).map({ index in
//                       .i_randomImgUrl(size: .init(width: 120, height: 120), id: "\(index)")
//               })
        return data
    }
}
