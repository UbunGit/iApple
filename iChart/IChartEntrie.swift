//
//  IChartEntrie.swift
//  iTest
//
//  Created by admin on 2023/8/1.
//

import Foundation

open class IChartEntrie{
    public  var x:Double
    public  var y:Double
    public  var info:Any? = nil
    
    public init(x: Double, y: Double,info:Any? = nil) {
        self.x = x
        self.y = y
        self.info = info
    }
    
    public static func random(count:Int = 25,
                       minvalue:Double = 0,
                       maxValue:Double = 100)->[IChartEntrie]{
        
        return (0..<25).map{ index in
            return IChartEntrie.init(x: Double(index), y: Double.random(in: (minvalue...maxValue)))
        }
    }
}
