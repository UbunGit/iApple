//
//  PathView.swift
//  CocoaLumberjack
//
//  Created by admin on 2023/12/15.
//

import Foundation
import UIKit

open class IBezierPathMaskView:UIView{

    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    public lazy var defualpath:UIBezierPath = {
        let setup = 1.0
        let path = UIBezierPath()
        let width = self.bounds.width
        let height = self.bounds.height
        
        let x1 = 0.9923*width
        let y1 = 0.42593*height
        path.move(to: CGPoint(x: x1, y: y1))
        
        let x2 = 0.6355*width
        let y2 = height
        let cp2_1 =  CGPoint(x: 0.92554*width, y: 0.77749*height)
        let cp2_2 =  CGPoint(x: 0.91864*width, y: height)
        path.addCurve(to: CGPoint(x: x2, y: y2),
                      controlPoint1: cp2_1,
                      controlPoint2: cp2_2)
        
        path.addCurve(to: CGPoint(x: 0.08995*width, y: 0.60171*height), controlPoint1: CGPoint(x: 0.35237*width, y: height), controlPoint2: CGPoint(x: 0.2695*width, y: 0.77304*height))
        path.addCurve(to: CGPoint(x: 0.34086*width, y: 0.06324*height), controlPoint1: CGPoint(x: -0.0896*width, y: 0.43038*height), controlPoint2: CGPoint(x: 0.00248*width, y: 0.23012*height))
        path.addCurve(to: CGPoint(x: 0.9923*width, y: 0.42593*height), controlPoint1: CGPoint(x: 0.67924*width, y: -0.10364*height), controlPoint2: CGPoint(x: 1.05906*width, y: 0.07436*height))
      
        path.close()
        
        return path
    }()
   
   
    public lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.opacity = 0.75
        return gradientLayer
    }()
   
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
  
        gradientLayer.frame = rect
        let path = defualpath
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
        
    }
}

