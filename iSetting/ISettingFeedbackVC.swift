//
//  ISettingFeedbackVC.swift
//  iPods
//
//  Created by admin on 2023/7/26.
//

import UIKit
import IQKeyboardManagerSwift
open class ISettingFeedbackVC: UIViewController {

    lazy var commitBtn: UIButton = {
        let value = UIButton()
        value.setTitle("提交", for: .normal)
        value.backgroundColor = view.tintColor.withAlphaComponent(0.35)
        value.i_radius = 12
        return value
    }()
    lazy var contentTextView: IQTextView = {
        let value = IQTextView()
        value.backgroundColor = .systemGroupedBackground
        value.i_radius = 12
        value.font = .systemFont(ofSize: 16)
        value.placeholder = "请留下您宝贵的意见或使用过程中遇到的问题"
        return value
    }()
    
    lazy var contactTextField: UITextField = {
        let value = UITextField()
        value.backgroundColor = .systemGroupedBackground
        value.i_radius = 12
        value.font = .systemFont(ofSize: 16)
        value.placeholder = "请留下联系方式，方便我们联系您"
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        title = "意见反馈"
        makeUI()
        makeLayout()
        
    }
    open func makeUI(){
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = .init(customView: commitBtn)
        view.addSubview(contentTextView)
        view.addSubview(contactTextField)
    }
    open func makeLayout(){
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(120)
        }
        contactTextField.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(8)
            make.left.equalTo(contentTextView)
            make.right.equalTo(contentTextView)
            make.height.equalTo(52)
        }
        commitBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 64, height: 32))
        }
        
    }
    
    open func commitClick(){
        guard let content = contentTextView.text,
              content.count>0 else {
            view.tost(msg: "请留下您宝贵的意见或使用过程中遇到的问题")
            return
        }
    }
}
