//
//  CircleProgressView.swift
//  Alamofire
//
//  Created by mac on 2023/4/19.
//

import Foundation

import Foundation
import UIKit

open class CircleProgressView: UIView {
    // 灰色静态圆环
    var staticLayer: CAShapeLayer!
    // 进度可变圆环
    var arcLayer: CAShapeLayer!
    
    // 为了显示更精细，进度范围设置为 0 ~ 1
    var progress:Double = 0.1

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setProgress(_ progress: Double) {
        self.progress = progress
        setNeedsDisplay()
    }
    
    open override func draw(_ rect: CGRect) {
        if staticLayer == nil {
            staticLayer = createLayer(1, .gray)
        }
        self.layer.addSublayer(staticLayer)
        if arcLayer != nil {
            arcLayer.removeFromSuperlayer()
        }
        arcLayer = createLayer(self.progress, .blue)
        self.layer.addSublayer(arcLayer)
    }
    
    private func createLayer(_ progress: Double, _ color: UIColor) -> CAShapeLayer {
        let endAngle = -CGFloat.pi / 2 + (CGFloat.pi * 2) * CGFloat(progress)
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = color.cgColor
        layer.fillColor = UIColor.clear.cgColor
        let radius = self.bounds.width / 2 - layer.lineWidth
        let path = UIBezierPath.init(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: radius, startAngle: -CGFloat.pi / 2, endAngle: endAngle, clockwise: true)
        layer.path = path.cgPath
        return layer
    }

}
