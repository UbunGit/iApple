//
//  UIView.swift
//  iApple
//
//  Created by mac on 2023/2/28.
//

import Foundation
@IBDesignable
public extension UIView{
    static func initWithNib() -> Self {
        let className = "\(self)"
        let nibName = className.split{$0 == "."}.map(String.init).last!
        return Bundle.main.loadNibNamed(nibName, owner: self)?.first as! Self
    }
    @objc var i_radius: CGFloat {
        set {
            layer.cornerRadius = newValue
            if newValue>0 {
                layer.masksToBounds = true
            }else{
                layer.masksToBounds = false
            }
        }
        get {
            layer.cornerRadius
        }
    }
    
    func i_radius(topLeft:CGFloat,
                  topRight:CGFloat,
                  bottomRight:CGFloat,
                  bottomLeft:CGFloat,
                  bounds:CGRect? = nil){
        let tbounds:CGRect = bounds ?? self.bounds
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: topLeft))
        path.addArc(withCenter: CGPoint(x: topLeft, y: topLeft), radius: topLeft, startAngle: .pi, endAngle: -(.pi/2), clockwise: true)
        path.addLine(to: CGPoint(x: tbounds.width - topRight, y: 0))
        path.addArc(withCenter: CGPoint(x: tbounds.width - topRight, y: topRight), radius: topRight, startAngle: -(.pi/2), endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height - bottomRight))
        path.addArc(withCenter: CGPoint(x: tbounds.width - bottomRight, y: tbounds.height - bottomRight), radius: bottomRight, startAngle: 0, endAngle: .pi/2, clockwise: true)
        path.addLine(to: CGPoint(x: bottomLeft, y: tbounds.height))
        path.addArc(withCenter: CGPoint(x: bottomLeft, y: tbounds.height - bottomLeft), radius: bottomLeft, startAngle: .pi/2, endAngle: .pi, clockwise: true)
        path.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
      
    }
}
