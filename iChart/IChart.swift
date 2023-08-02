//
//  IBoxBaseViewController.swift
//  iApple
//
//  Created by admin on 2023/7/26.
//

import Foundation
public protocol IChartFormatter{
    func stringForValue(_ value: Double) -> String
}
struct DefualIChartFormatter:IChartFormatter{
    func stringForValue(_ value: Double) -> String {
        return value.formatter()
    }
}
public extension UIView{
    
    func drawText(_ text:String,
                  attributes:[NSAttributedString.Key:Any]? = nil,
                  rect: CGRect
    ){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes:[NSAttributedString.Key:Any] = attributes ?? [
            .font: UIFont.systemFont(ofSize: 12),
            .paragraphStyle: paragraphStyle
        ]
       
        text.draw(in: rect, withAttributes: attributes)
    }
    
    func drawCapsule(color:UIColor,cornerRadii:CGFloat,rect: CGRect){
        let expendpath = UIBezierPath(
            roundedRect:rect,
            byRoundingCorners: [.topLeft,.topRight,.bottomRight,.bottomLeft],
            cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        color.setFill()
        expendpath.fill()
    }
    
    func drawLine(points:[CGPoint],rect: CGRect){
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let startPoint = CGPoint(x: 50, y: 200)
        let endPoint = CGPoint(x: rect.width - 50, y: 200)
        
        context.move(to: startPoint)
        context.addCurve(to: endPoint, control1: CGPoint(x: rect.width / 2, y: 100), control2: CGPoint(x: rect.width / 2, y: 300))
        
        context.setLineWidth(2)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.strokePath()
    }
    
    func drawYAxis(rect: CGRect,
                   values:[Double],
                   count:Int=4,
                   formmate:IChartFormatter? = nil ){
        let formate:IChartFormatter = formmate ?? DefualIChartFormatter()
        let min:Double = values.min() ?? 0
        let max:Double = values.max() ?? 1
        let step = (max-min)/4
//        let xUnit = rect.width / count
        let yUnit = rect.height / CGFloat(count)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.fill()
        
        (0..<count).forEach { item in
            let text = formate.stringForValue(Double(item)*step)
            let y = rect.height - yUnit*Double(item) - 16
            let t_rect:CGRect = .init(x: rect.origin.x, y: y, width: rect.width, height: 16)
            drawText(text, attributes: nil, rect: t_rect)
          
        }

    }
}
