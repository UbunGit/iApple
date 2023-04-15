//
//  IInputTextViewCell.swift
//  GoogleUtilities
//
//  Created by mac on 2023/4/15.
//

import UIKit
import IQKeyboardManagerSwift

open class IInputTextViewCell<T:Any>: IInputBaseTableViewCell<T> {

    open lazy var textView: IQTextView = {
        let value = IQTextView()
        value.placeholder = "请输入内容"
        value.font = .systemFont(ofSize: 16)
        value.textContainerInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        return value
    }()
    
    open override func makeUI() {
        super.makeUI()
        contentView.addSubview(textView)
    }
    open override func makeLayout() {
        textView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
    }

}
