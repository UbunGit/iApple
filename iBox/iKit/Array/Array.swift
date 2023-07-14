//
//  Array.swift
//  Alamofire
//
//  Created by mac on 2023/7/14.
//

import Foundation

public extension Array{
    func index(at index: Int) -> Element? {
        guard index >= 0 && index < count else {
            return nil
        }
        return self[index]
    }
}
