//
//  iInputTextFieldCell.swift
//  iApple
//
//  Created by mac on 2023/4/15.
//

import UIKit

open class IInputTextFieldCell<T:Any>: IInputBaseTableViewCell<T> {
    
    open lazy var textField : UITextField = {
        let value = UITextField()
        value.placeholder = "请输入内容"
        value.font = .systemFont(ofSize: 16)
        value.leftView = UIView.init(frame: .init(x: 0, y: 0, width: 12, height: 8))
        value.leftViewMode = .always
        return value
    }()
    
    open override func makeUI() {
        super.makeUI()
        contentView.addSubview(textField)
    }
    open override func makeLayout() {
        textField.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
   

}
