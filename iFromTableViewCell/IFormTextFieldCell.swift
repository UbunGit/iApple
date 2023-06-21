//
//  iInputTextFieldCell.swift
//  iApple
//
//  Created by mac on 2023/4/15.
//

import UIKit

open class IFormTextFieldCell<T:Any>: IFormBaseCell<T> {
  
    open lazy var textField : IKitLeftLableTextField = {
        let value = IKitLeftLableTextField(frame: .init(x: 0, y: 0, width: 82, height: 44))
        value.placeholder = "请输入内容"
        value.font = .systemFont(ofSize: 16)
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
            make.height.equalToSuperview()
        }
    }
}

open class IFormTextFieldWithTitleCell<T:Any>: IFormBaseCell<T> {
  
   public lazy var titleLab: UILabel = {
        let value = UILabel()
        value.font = .boldSystemFont(ofSize: 14)
        return value
    }()
    open lazy var textField : IKitTextField = {
        let value = IKitTextField()
        value.leftView = UIView.init(frame: .init(x: 0, y: 0, width: 12, height: 12))
        value.placeholder = "请输入内容"
        value.font = .systemFont(ofSize: 16)
        value.leftViewMode = .always
        return value
    }()
    
    open override func makeUI() {
        super.makeUI()
        contentView.addSubview(titleLab)
        contentView.addSubview(textField)
       
    
    }
    open override func makeLayout() {
        super.makeLayout()
        titleLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(32)
        }
       
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom)
            make.left.equalToSuperview().offset(12)
            make.bottom.equalTo(-12)
            make.right.equalToSuperview().offset(-12)
        }
    }
}
