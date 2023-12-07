//
//  CALayer+ARC.swift
//  Alamofire
//
//  Created by admin on 2023/10/25.
//

import Foundation
public extension CALayer{

    func addArc(withCenter pathCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat = CGFloat.pi * 2, clockwise: Bool = true){
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.anchorPoint = .init(x: 0, y: 1)
        let path = UIBezierPath()
      
        path.addArc(withCenter: pathCenter, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: clockwise)

        shapeLayer.path = path.cgPath

        addSublayer(shapeLayer)
        // 创建旋转动画
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 50.0
        rotationAnimation.repeatCount = .infinity
 
        shapeLayer.add(rotationAnimation, forKey: "rotationAnimation1")
        
    }
    
}
