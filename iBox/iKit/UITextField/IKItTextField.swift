//
//  IKItTextField.swift
//  Alamofire
//
//  Created by mac on 2023/6/2.
//

import Foundation
import UIKit

open class IKitTextField:UITextField{
    
    public var leftViewRectBlock:((IKitTextField)->CGRect)? = nil
    public var rightViewRectBlock:((IKitTextField)->CGRect)? = nil
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
        if let block = leftViewRectBlock{
            return block(self)
        }
        guard let leftView = leftView else{
            return super.leftViewRect(forBounds: bounds)
        }
        let x:CGFloat = 0
        let y = (bounds.size.height-(leftView.bounds.height))/2
        return .init(origin: .init(x: x, y: y), size: leftView.bounds.size)
    }
    
    open override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        if let block = rightViewRectBlock{
            return block(self)
        }
        guard let rightView = rightView else{
            return super.leftViewRect(forBounds: bounds)
        }
        let x = bounds.width-(rightView.bounds.width)
        let y = (bounds.size.height-(rightView.bounds.height))/2
        return .init(origin: .init(x: x, y: y), size: rightView.bounds.size )
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
