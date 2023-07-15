//
//  TrendsUser.swift
//  Trends
//
//  Created by mac on 2023/7/14.
//

import Foundation

public final class Member:ObservableObject,Identifiable{
    var uuid:String?
    var avatar:URL?
    var nickName:String = ""
    var signature:String = ""
    var isBlue:Bool = false
    @Published var isFollow:Bool = false
}
extension Member:Mock{
    public class func mock() -> Member {
        let data = Member()
        data.avatar = .i_randomImageURL
        data.isBlue = .random()
        data.nickName = .i_random_zh
        data.signature = .i_random_zh
        return data
    }
}
