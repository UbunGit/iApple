//
//  SHCircleBar.swift
//  SHCircleBar
//
//  Created by Adrian Perțe on 19/02/2019.
//  Copyright © 2019 softhaus. All rights reserved.
//

import UIKit



@IBDesignable public class SHCircleBar: UITabBar {
    class CircleView:UIView{
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(circleImageView)
            circleImageView.frame = self.bounds
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        lazy var circleImageView: UIImageView = {
            let value = UIImageView()
            return value
        }()
    }
    public lazy var customView: UIView = {
        let value = UIView()
        value.backgroundColor = .systemBackground
        return value
    }()
    
    lazy var circleView: UIView = {
        let value = UIView()
        return value
    }()
    
    private var tabWidth: CGFloat = 0
    private var index: CGFloat = 0 {
        willSet{
            self.previousIndex = index
        }
    }
    private var animated = false
    private var selectedImage: UIImage?
    private var previousIndex: CGFloat = 0
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChangeNotification), name: UIDevice.orientationDidChangeNotification, object: nil)
        customInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
        
    }
    
    open override func draw(_ rect: CGRect) {
        drawCurve()
    }
    deinit{
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    @objc func orientationDidChangeNotification(){
        customView.frame = .init(x: 0, y: 0, width: i_screen_w, height: 49+UIScreen.i_safeAreaInsets.bottom)
    }
}

extension SHCircleBar {
    func tabBarButtons()->[UIView]{
        subviews.filter { String(describing: type(of: $0)) == "UITabBarButton" }
    }
    func tabBarButton(index:Int)->UIView?{
        subviews.filter { String(describing: type(of: $0)) == "UITabBarButton" }[index]
    }
    func select(itemAt: Int, animated: Bool) {
        self.index = CGFloat(itemAt)
        self.animated = animated
        self.selectedImage = self.selectedItem?.selectedImage
        tabBarButtons().forEach { $0.alpha = 1 }
        tabBarButton(index: itemAt)?.alpha = 0
        self.setNeedsDisplay()
    }
    
    private func drawCurve() {
        let fillColor: UIColor = self.backgroundColor ?? .white
        tabWidth = self.bounds.width / CGFloat(self.items!.count)
		
        let bezPath = drawPath(for: index)
        
        bezPath.close()
        fillColor.setFill()
        bezPath.fill()
        let mask = CAShapeLayer()
        mask.fillRule = .evenOdd
//        mask.fillColor = UIColor.white.cgColor
        mask.path = bezPath.cgPath
        if (self.animated) {
            let bezAnimation = CABasicAnimation(keyPath: "path")
            let bezPathFrom = drawPath(for: previousIndex)
            bezAnimation.toValue = bezPath.cgPath
            bezAnimation.fromValue = bezPathFrom.cgPath
            bezAnimation.duration = 0.3
            bezAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            mask.add(bezAnimation, forKey: nil)
        }
        customView.layer.mask = mask
    }
    
    private func customInit(){
        addSubview(customView)
        customView.frame = .init(x: 0, y: 0, width: i_screen_w, height: 49+UIScreen.i_safeAreaInsets.bottom)
        self.tintColor = .red
        self.barTintColor = .red
        self.backgroundColor = .clear
    }
    
    private func drawPath(for index: CGFloat) -> UIBezierPath {
     
        let bezPath = UIBezierPath()
     
        
        let leftPoint = CGPoint(x:(tabWidth * index) + tabWidth/2 - 38,
                                y: 0)

        let centen = CGPoint.init(x: tabWidth*index+tabWidth/2, y: 0)
        bezPath.move(to: leftPoint)
        bezPath.addArc(withCenter: centen, radius: 38, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: true)
        bezPath.append(UIBezierPath(rect: self.bounds))

        return bezPath
    }
}

