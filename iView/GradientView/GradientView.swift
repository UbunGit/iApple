//
//  GradientView.swift
//  Alamofire
//
//  Created by mac on 2023/4/20.
//

import Foundation

public class GradientView: UIView {

    public var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    public var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    public var colors:[UIColor] = [.white.withAlphaComponent(0.35),.white]{
        didSet{
            updateColors()
        }
    }
    public  var locations:[Double] = [0.05,0.95]{
        didSet{
            updateLocations()
        }
    }
    
    override public class var layerClass: AnyClass { CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addObserverBlock(forKeyPath: "bounds") { _, _, _ in
            self.updatePoints()
            self.updateLocations()
            self.updateColors()
            self.gradientLayer.frame = self.bounds
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = locations.map{ $0 as NSNumber }
    }
    func updateColors() {
        gradientLayer.colors = colors.map{ $0.cgColor }
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    
    }
    
}


