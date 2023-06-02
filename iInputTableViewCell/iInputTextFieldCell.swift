//
//  iInputTextFieldCell.swift
//  iApple
//
//  Created by mac on 2023/4/15.
//

import UIKit

open class IInputTextFieldCell<T:Any>: IInputBaseTableViewCell<T> {
  
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
