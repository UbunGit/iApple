//
//  Array.swift
//  Alamofire
//
//  Created by mac on 2023/7/14.
//

import Foundation

public extension Array{
    func value(at index: Int) -> Element? {
        guard index >= 0 && index < count else {
            return nil
        }
        return self[index]
    }
    
    func i_randomElements(count: Int) -> [Element] {
        var elements: [Element] = []
        var mutableArray = self
        
        for _ in 0..<count {
            let randomIndex = Int.random(in: 0..<mutableArray.count)
            let element = mutableArray.remove(at: randomIndex)
            elements.append(element)
        }
        
        return elements
    }
}
