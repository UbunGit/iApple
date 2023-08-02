//
//  CellData.swift
//  iApple
//
//  Created by admin on 2023/7/26.
//

import Foundation
public struct GroupData{
    public var title:String
    public var items:[ItemData]
    
    public struct ItemData{
        var title:String
        var value:(()->String?)? = nil
        var handle:(()->())? = nil
    }
}

