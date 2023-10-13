//
//  iKit+CAGradientLayer.swift
//  Alamofire
//
//  Created by admin on 2023/9/28.
//

import Foundation

public extension CAGradientLayer{
    convenience init(
        colors: [UIColor],
        locations: [CGFloat]? = nil,
        startPoint: CGPoint = CGPoint(x: 0.5, y: 0),
        endPoint: CGPoint = CGPoint(x: 0.5, y: 1),
        type: CAGradientLayerType = .axial
    ) {
        self.init()
        self.colors = colors.map(\.cgColor)
        self.locations = locations?.map { NSNumber(value: Double($0)) }
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.type = type
    }
}
