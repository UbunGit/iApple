//
//  ILoginPhoneTextFeld.swift
//  iApple
//
//  Created by mac on 2023/7/19.
//

import UIKit

open class ILoginPhoneTextField: UITextField {

    lazy var leftLab: UILabel = {
        let value = UILabel()
        value.textAlignment = .center
        value.textColor = tintColor
        value.font = .systemFont(ofSize: 16,weight: .heavy)
        return value
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        leftView = leftLab
        keyboardType = .phonePad
        font = .systemFont(ofSize: 16,weight: .heavy)
        self.leftViewMode = .always
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return .init(x: 0, y: 0, width: 120, height: bounds.height)
    }
}
