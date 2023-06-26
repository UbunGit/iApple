//
//  IKItTextField.swift
//  Alamofire
//
//  Created by mac on 2023/6/2.
//

import Foundation
import UIKit

open class IKitTextField:UITextField{

    open override var leftView: UIView?{
        didSet{
            leftViewMode = leftView == nil ? .never : .always
        }
    }
    open override var rightView: UIView?{
        didSet{
            rightViewMode = (rightView == nil) ? .never : .always
        }
    }
    open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        
        guard let leftView = leftView else{
            return super.leftViewRect(forBounds: bounds)
        }
        let w = leftView.frame.size.width
        let h = bounds.size.height
        return  .init(origin: .zero, size: .init(width: w, height: h))
    }
    
    open override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        
        guard let rightView = rightView else{
            return super.leftViewRect(forBounds: bounds)
        }
        let x = bounds.width-(rightView.bounds.width)
        let y = (bounds.size.height-(rightView.bounds.height))/2
        let h = bounds.size.height
        let w = rightView.bounds.size.width
        return .init(origin: .init(x: x, y: y), size: .init(width: w, height: h) )
    }
}

open class IKitLeftLableTextField:IKitTextField{
    
    public lazy var letftLab: UILabel = {
        let value = UILabel(frame: .init(origin: .zero, size: .init(width: 84, height: 44)))
        value.textColor = .label
        value.font = .boldSystemFont(ofSize: 16)
        value.textAlignment = .center
        return value
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeLayout()
    }
    
    func makeUI(){
        
        leftView = letftLab
    }
    func makeLayout(){
        
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
