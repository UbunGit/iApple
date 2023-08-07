//
//  IChartFormatter.swift
//  iTest
//
//  Created by admin on 2023/8/1.
//

import Foundation

public protocol IChartFormatter{
    func stringForValue(_ value: Double) -> String
}
extension IChartFormatter{
    func stringForValue(_ value: Double) -> String {
        value.formatter()
    }
}

open class IChartXAxisFormatter:IChartFormatter{
    public func stringForValue(_ value: Double) -> String {
        return String.init(format: "%@", value)
    }
}
