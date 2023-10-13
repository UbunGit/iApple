//
//  IBaseModel.swift
//  iApple
//
//  Created by admin on 2023/9/16.
//

import Foundation

open class IBaseGroup<T:Any>{
    public var title:String? = nil
    public var items:[T] = []
    public init(title: String? = nil, items: [T]) {
        self.title = title
        self.items = items
    }
    
}
