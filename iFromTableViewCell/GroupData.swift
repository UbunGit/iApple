//
//  CellData.swift
//  iApple
//
//  Created by admin on 2023/7/26.
//

import Foundation
public struct GroupData{
    public var title:String? = nil
    public var tag:Int = 0
    public var items:[ItemData]
    
    public init(title: String? = nil,tag:Int, items: [ItemData]) {
        self.title = title
        self.tag = tag
        self.items = items
    }
    
    public struct ItemData{
        var title:String
        public var tag:Int = 0
        var value:(()->String?)? = nil
        var handle:(()->())? = nil
        
        public init(title: String,
                    tag:Int,
                    value: ( () -> String?)? = nil,
                    handle: ( () -> Void)? = nil) {
            self.title = title
            self.tag = tag
            self.value = value
            self.handle = handle
        }
    }
}

