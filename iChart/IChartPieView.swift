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
         super.reload()
         
         
     }
     
     required public init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}

open class IChartPieDrawView:IChartDrawView{
    var  lineWidth:CGFloat = 40
    
   
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 底圆
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: rect.midY, y: rect.midY), radius: (rect.size.width-lineWidth) / 2, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        circlePath.lineWidth = lineWidth
        UIColor.systemBackground.setStroke()
        circlePath.stroke()
     
        let all = dataSet.entyrs.reduce(0) { partialResult, entrie in
            return partialResult+entrie.y
        }
        var offset:CGFloat = 0.75
        
        dataSet.entyrs.forEach { entrie in
            guard let entrie = entrie as? IChartPieEntrie else{
                return
            }
            let angle = entrie.y/all
            let end = offset + angle
            
            let startAngle = 2*CGFloat.pi * offset
            let endAngle = 2*CGFloat.pi * (end-0.01)
            debugPrint("offset:\(offset) end:\(end)")
            debugPrint("startAngle:\(startAngle) endAngle:\(endAngle)")
            let circlePath1 = UIBezierPath(
                arcCenter: CGPoint(x: rect.midY, y: rect.midY),
                radius: (rect.size.width-lineWidth) / 2,
                startAngle:startAngle,
                endAngle: endAngle,
                clockwise: true)
            circlePath1.lineWidth = lineWidth
            circlePath1.lineCapStyle = .butt
            entrie.color.withAlphaComponent(0.35).setStroke()
            circlePath1.stroke()
            offset = end
        }

    }
}
