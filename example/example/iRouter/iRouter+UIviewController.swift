//
//  iRouter+UIviewController.swift
//  example
//
//  Created by mac on 2023/4/15.
//

import Foundation
import UIKit
import iApple

public typealias VCRouter = String

extension VCRouter{
    static let adhome = "app://ad.home"
    static let mediaImportList = "app://media.importList"
}
extension ADHomeViewController:I_RouterProtocol{
    
    static func routerUrl() -> String {
        return VCRouter.adhome
    }
}
extension EXMeidaInportListVC:I_RouterProtocol{
    
    static func routerUrl() -> String {
        return VCRouter.mediaImportList
    }
}

