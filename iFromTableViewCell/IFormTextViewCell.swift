//
//  IInputTextViewCell.swift
//  GoogleUtilities
//
//  Created by mac on 2023/4/15.
//

import UIKit
import IQKeyboardManagerSwift

open class IFormTextViewCell<T:Any>: IFormBaseCell<T> {
    open lazy var placeholderLab:UILabel  = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 12)
        value.textColor = .secondaryLabel
        return value
    }()
    open lazy var textView: IQTextView = {
        let value = IQTextView()
        value.placeholderTextColor = .tertiaryLabel
        value.placeholder = "请输入内容"
        value.font = .systemFont(ofSize: 16)
        value.textContainerInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        return value
    }()
    
    open override func makeUI() {
        super.makeUI()
        contentView.addSubview(textView)
        contentView.addSubview(placeholderLab)
    }
    open override func makeLayout() {
        placeholderLab.snp.makeConstraints { make in
            make.bottom.equalTo(textView.snp.top)
            make.left.equalToSuperview()
        }
        textView.snp.makeConstraints { make in
            make.left.top.equalTo(8)
            make.right.bottom.equalTo(-8)
           
        }
    }

}
