//
//  CellData.swift
//  iPods
//
//  Created by admin on 2023/7/26.
//

import Foundation
public struct GroupData{
    
    public var title:String?
    public var items:[ItemData]
    
    public init(title: String?, items: [ItemData]) {
        self.title = title
        self.items = items
    }
    public struct ItemData{
        var title:String
        var cellType:UITableViewCell.Type
        var value:(()->String?)? = nil
        var handle:(()->())? = nil
        
        public init(title: String,
                    cellType:UITableViewCell.Type,
                    value: (() -> String?)? = nil,
                    handle: ( () -> Void)? = nil) {
            self.title = title
            self.cellType = cellType
            self.value = value
            self.handle = handle
        }
    }
    
}

//public extension GroupData.ItemData{
//    
//    func cellwith(tableView:UITableView,indexPath:IndexPath)->UITableViewCell{
//        tableView.i_registerCell(cellType)
//        return tableView.i_dequeueReusableCell(cellType, for: indexPath)
//    }
//}



