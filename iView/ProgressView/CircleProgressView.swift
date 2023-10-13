//
//  CircleProgressView.swift
//  iApple
//
//  Created by admin on 2023/10/6.
//

import Foundation
import UIKit

open class CircleProgressView: UIView {
    
    public var trackColor:UIColor = UIColor.systemGroupedBackground{
        didSet{
            trackLayer.strokeColor = trackColor.cgColor
            setNeedsDisplay()
        }
    }
    
    public var progressColor:UIColor = UIColor.green{
        didSet{
            progressLayer.strokeColor = progressColor.cgColor
            setNeedsDisplay()
        }
    }
    
    public var progress:CGFloat = 0.1{
        didSet{
            setNeedsDisplay()
        }
    }
    public var lineWidth:CGFloat = 10{
        didSet{
            trackLayer.lineWidth = lineWidth
            progressLayer.lineWidth = lineWidth
            setNeedsDisplay()
        }
    }
    public lazy var trackLayer: CAShapeLayer = {
        let value = CAShapeLayer()
        value.strokeColor = trackColor.cgColor
        value.lineWidth = lineWidth
        value.fillColor = UIColor.clear.cgColor
        return value
    }()
    public lazy var progressLayer: CAShapeLayer = {
        let value = CAShapeLayer()
        value.strokeColor = progressColor.withAlphaComponent(0.85).cgColor
        value.lineWidth = lineWidth
        value.fillColor = UIColor.clear.cgColor
        value.lineCap = .round; //线条拐角
        value.lineJoin = .round; //终点处理
        return value
    }()
    public lazy var gradientLayer: CAGradientLayer = {
        let value = CAGradientLayer()
        value.colors = [UIColor.red.cgColor,UIColor.clear.cgColor]
        value.startPoint = .init(x: 0.5, y: 0)
        value.endPoint = .init(x: 0.5, y: 1)
        return value
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeLayout()
    }
    
    func trackPath()->UIBezierPath{
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2  // 圆环的半径
        debugPrint(radius,lineWidth)
        let startAngle: CGFloat = CGFloat.pi*1.5
        let endAngle: CGFloat = 2 * CGFloat.pi + startAngle // 圆环的结束角度
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineCapStyle = .round
        return path
    }
    
    func progressPath()->UIBezierPath{
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2// 圆环的半径
        let startAngle: CGFloat =  CGFloat.pi*1.5
        let endAngle: CGFloat = (2 * CGFloat.pi)*progress + startAngle // 圆环的结束角度
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineCapStyle = .round
        return path
    }
    
    func makeUI(){

        layer.addSublayer(trackLayer)
        layer.addSublayer(gradientLayer)
        layer.addSublayer(progressLayer)
     
    }
    func makeLayout(){
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open override func draw(_ rect: CGRect) {
        
        let trackPath = trackPath()
        trackLayer.path = trackPath.cgPath
        trackLayer.frame = rect
        
        let progressPath = progressPath()
      
        progressLayer.path = progressPath.cgPath
        progressLayer.frame = rect
        
        gradientLayer.frame = rect
        gradientLayer.mask = progressLayer
        
        
       
        
        
       
    }
    
    
}
