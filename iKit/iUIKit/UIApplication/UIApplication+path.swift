//
//  File.swift
//  iPods
//
//  Created by mac on 2023/2/25.
//

import Foundation
public extension UIApplication{
    var i_documentPaths: [String]{
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                   FileManager.SearchPathDomainMask.userDomainMask, true)
    }
    var i_documnetPath:String{
        i_documentPaths[0]
    }
    
    var i_documnetPathUrl:URL{
        .init(fileURLWithPath: i_documnetPath)
    }
}
