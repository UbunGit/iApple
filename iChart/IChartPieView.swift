//
//  IChartPieView.swift
//  iApple
//
//  Created by 恋遇 on 2023/8/8.
//

import Foundation
open class IChartPieEntrie:IChartEntrie{
    var color = UIColor.random.withAlphaComponent(0.15)
    public init(x: Double, y: Double,color:UIColor, info: Any? = nil) {
        self.color = color
        super.init(x: x, y: y, info: info)
    }
}
open class IChartPieView:IChartView{
    
    
     public override init(frame: CGRect) {
         super.init(frame: frame)
     }
   
     open override func makeUI() {
    
         drawView = IChartPieDrawView()
         dataSet = IChartDataSet(entyrs: IChartEntrie.random())

         super.makeUI()
     }
     open override func makeLayoout() {
         super.makeLayoout()
     }
   
     public override func reload(){
         guard let drawView = drawView as? IChartPieDrawView else{
             return
         }
         drawView.selectIndex = nil
         super.reload()
         
     }
     
     required public init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}

open class IChartPieDrawView:IChartDrawView{
    var selectIndex:Int? = nil
    struct EntyrsAngle{
        var begin:CGFloat
        var end:CGFloat
    }
    var lineWidth:CGFloat = 40
    var entyrsAngles:[EntyrsAngle] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture)))
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func angleDegrees(point1:CGPoint,point2:CGPoint)->CGFloat{
       
        // 计算向量AB的差值
        let deltaX = point2.x - point1.x
        let deltaY = point2.y - point1.y

        // 计算夹角（弧度制）
        let angle = atan2(deltaY, deltaX)

        // 将弧度转换为度数
        let angleDegrees = angle * (180 / .pi)

        // 调整角度，使90度为零角
        var adjustedAngleDegrees = (angleDegrees + 360).truncatingRemainder(dividingBy: 360)
        // 将负数角度转换为正数角度
        if adjustedAngleDegrees < 0 {
            adjustedAngleDegrees += 360
        }
        print("夹角（弧度制）: \(angle)")
        print("夹角（度数）: \(adjustedAngleDegrees)")
        return adjustedAngleDegrees
    }
   
    @objc func tapGesture(gesture:UIGestureRecognizer){
        let tapLocation = gesture.location(in: self)
        let angleDegrees = angleDegrees(point1: self.center, point2: tapLocation)
        selectIndex = entyrsAngles.firstIndex { item in
            debugPrint("item.begin:\(item.begin),item.end:\(item.end)")
           return angleDegrees > item.begin &&  angleDegrees <= item.end
        }
        self.setNeedsDisplay()

    }
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 底圆
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: rect.midY, y: rect.midY), radius: (rect.size.width-lineWidth) / 2, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        circlePath.lineWidth = lineWidth
        UIColor.systemGroupedBackground.setStroke()
        circlePath.stroke()
     
        let all = dataSet.entyrs.reduce(0) { partialResult, entrie in
            return partialResult+entrie.y
        }
        var offset:CGFloat = 0
        entyrsAngles = []
        let space:CGFloat = (dataSet.entyrs.count>1) ? 5 : 0
        dataSet.entyrs.enumerated().forEach { (index,entrie) in
            guard let entrie = entrie as? IChartPieEntrie else{
                return
            }
            let startAngle = offset
            // 将数值转换成角度 360
            let angle = (entrie.y/all)*360
            let endAngle = offset + angle
            
           
            
            entyrsAngles.append(.init(begin: startAngle, end: endAngle))
            let circlePath1 = UIBezierPath(
                arcCenter: CGPoint(x: rect.midY, y: rect.midY),
                radius: (rect.size.width-lineWidth) / 2,
                startAngle:startAngle / (180 / .pi),
                endAngle: (endAngle-space) / (180 / .pi),
                clockwise: true)
            
            circlePath1.lineCapStyle = .butt
            
            if index==selectIndex{
                circlePath1.lineWidth = lineWidth
                entrie.color.setStroke()
            }else{
                circlePath1.lineWidth = lineWidth-10
                entrie.color.withAlphaComponent(0.65).setStroke()
            }
    
            circlePath1.stroke()
            offset = endAngle
        }

    }
}
