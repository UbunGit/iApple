//
//  Mock.swift
//  Trends
//
//  Created by mac on 2023/7/15.
//

import Foundation
public protocol Mock{
    
    static func mock() -> Self
    static func mocks(num:Int) -> [Self]
}
public extension Mock{
    
    static func mocks(num:Int) -> [Self] {
 
        (0..<num).map { index in
            Self.mock()
        }
    }
}


