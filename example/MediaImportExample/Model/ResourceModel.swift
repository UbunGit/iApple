//
//  ResourceModel.swift
//  example
//
//  Created by mac on 2023/4/15.
//

import Foundation

class ResourceModel{
  
    var id:String
    
    var name:String
    
    var sourceUrl:URL
    
    init(sourceUrl: URL,id:String = UUID().uuidString, name:String? = nil) {
        self.id = id
        self.sourceUrl = sourceUrl
        self.name = name ?? self.sourceUrl.lastPathComponent
    }
}





