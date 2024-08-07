//
//  UIView.swift
//  iPods
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
    
    @MainActor
    @objc var i_radius: CGFloat {
        set {
            layer.cornerRadius = newValue
            if newValue>0 {
                clipsToBounds = true
//                layer.masksToBounds = false
            }else{
                clipsToBounds = false
//                layer.masksToBounds = false
            }
        }
        get {
            layer.cornerRadius
        }
    }
    
    @MainActor
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
    
    // 添加阴影
    @MainActor
    func i_shadow(opacity:Float = 0.35,
                  shadowColor:UIColor? = UIColor.black,
                  radius:CGFloat = 3,
                  offset:CGSize = .init(width: 2, height: 2)){
        
        
        layer.shadowOpacity = opacity;///不透明度
        layer.shadowColor = shadowColor?.cgColor;//阴影颜色
        layer.shadowRadius = radius;//半径大小
        layer.shadowOffset = offset
        layer.masksToBounds = false
       
        
    }
    // 移除阴影
    @MainActor
    func i_clearshadow(){
        self.layer.shadowOpacity=0 //不透明度
        self.layer.shadowColor = nil //阴影颜色
        self.layer.shadowRadius = 0 //半径大小
        self.layer.shadowOffset = .zero
    }
    
    // 边框
    @MainActor
    func i_border(width:CGFloat = 0.5,color:UIColor = .systemGroupedBackground){
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}

public extension UIView{
    
    func i_overlayGradientLayer(gradientLayer:CAGradientLayer){
        layer.addSublayer(gradientLayer)
        addObserverBlock(forKeyPath: "bounds") {[weak self] _, _, _ in
            guard let self = self else {return}
            layer.frame = self.bounds
        }
    }
    func i_overlayGradient(colors:[UIColor],locations:[NSNumber]){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map{ $0.cgColor}
        gradientLayer.locations = locations
        gradientLayer.startPoint = .init(x: 1, y: 0)
        gradientLayer.endPoint   = .init(x: 0, y: 1)
        
        i_overlayGradientLayer(gradientLayer: gradientLayer)
    }
}


public extension UIView{
    
    func addAnimation(_ animation:CAAnimation, forKey:String){
        animation.isRemovedOnCompletion = false;
        layer.add(animation, forKey: forKey)
    }
    
}



