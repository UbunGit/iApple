//
//  iInputTextFieldCell.swift
//  iApple
//
//  Created by mac on 2023/4/15.
//

import UIKit

open class IInputTextFieldCell<T:Any>: IInputBaseTableViewCell<T> {
    open lazy var placeholderLab:UILabel  = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 12)
        value.textColor = .secondaryLabel
        return value
    }()
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
        contentView.addSubview(placeholderLab)
    }
    open override func makeLayout() {
        placeholderLab.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        textField.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(placeholderLab.snp.top).offset(-4)
           
        }
    }
   

}
