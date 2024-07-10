//
//  GradientView.swift
//  Alamofire
//
//  Created by mac on 2023/4/20.
//

import Foundation

open class GradientView: UIView {
    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
    
    override public class var layerClass: AnyClass { CAGradientLayer.self }
    
    open var colors:[UIColor]?{
        set{
            gradientLayer.colors = newValue?.map{ $0.cgColor }
        }
        get{
            return gradientLayer.colors?.map{ UIColor.init(cgColor: $0 as! CGColor) }
        }
    }
        
    open var locations:[NSNumber]?{
        set{
            gradientLayer.locations = newValue
        }
        get{
            gradientLayer.locations
        }
    }
    
    open var startPoint: CGPoint{
        set{
            gradientLayer.startPoint = newValue
        }
        get{
            gradientLayer.startPoint
        }
    }

    open var endPoint: CGPoint{
        set{
            gradientLayer.endPoint = newValue
        }
        get{
            gradientLayer.endPoint
        }
    }

    open var type: CAGradientLayerType{
        set{
            gradientLayer.type = newValue
        }
        get{
            gradientLayer.type
        }
    }
}


