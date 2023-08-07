//
//  IChartDataSet.swift
//  iTest
//
//  Created by admin on 2023/8/1.
//

import Foundation

open class IChartDataSet{
    public var entyrs:[IChartEntrie]
    // 曲线的参数
    public var lineCurviness: CGFloat = 0.5
    // x坐标每个值之间的宽度
    public var cellWidth:CGFloat = 40
    public init(entyrs: [IChartEntrie]) {
        self.entyrs = entyrs.sorted(by: { $0.x<$1.x })
        reset()
    }
    
    var x_min:Double = 0
    var x_max:Double = 1
    var y_min:Double = 0
    var y_max:Double = 1
    
    open func reset(){
        x_min = 0
        x_max = 1
        y_min = 0
        y_max = 1
        entyrs.forEach { item in
            x_min = min(item.x, x_min)
            x_max = max(item.x, x_max)
            y_min = min(item.y, y_min)
            y_max = max(item.y, y_max)
        }
        debugPrint(x_min,x_max,y_min,y_max)
    }
    
    open func point(entyr:IChartEntrie,rect:CGRect) -> CGPoint{
        
        let p_x = entyr.x.normalized(min: x_min, max: x_max)
        let p_y = entyr.y.normalized(min: y_min, max: y_max)
        
        let w = rect.width-rect.origin.x - cellWidth
        let h = rect.height-rect.origin.y
        let x = rect.origin.x + w*p_x
        let y = (h + rect.origin.y)  - (h*p_y)
        return .init(x: x+cellWidth/2, y: y)
    }
    
    open func leftPoint(point:CGPoint,rect:CGRect) -> CGPoint{
        
        let p_x = point.x
        let p_y = point.y
        
        let w = rect.width-rect.origin.x - cellWidth
        let h = rect.height-rect.origin.y
        let x = rect.origin.x + w*p_x
        let y = (h + rect.origin.y)  - (h*p_y)
        return .init(x: x, y: y)
    }
    
}

