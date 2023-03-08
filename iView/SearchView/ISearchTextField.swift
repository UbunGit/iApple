//
//  ISearchTextField.swift
//  AEXML
//
//  Created by mac on 2023/3/8.
//

import Foundation
import UIKit
open class ISearchView:UIView{
    
   public lazy var textField: ISearchTextField = {
        let value = ISearchTextField()
        return value
    }()
    public lazy var cancelBtn: UIButton = {
        let value = UIButton()
        value.setTitle("取消", for: .normal)
        value.titleLabel?.font = .systemFont(ofSize: 16)
        value.setTitleColor(.red, for: .normal)
        value.addTarget(self, action: #selector(cancelBtnClickDoit), for: .touchUpInside)
        return value
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeLayout()
    }
    @objc func cancelBtnClickDoit(){
        textField.text = nil
        endEditing(true)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI(){
        addSubview(textField)
        addSubview(cancelBtn)
        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillShowNotification, object: nil, queue: .main) { _ in
            UIView.animate(withDuration: 0.35) {
                self.textField.searchIcon.tintColor = .secondaryLabel
            }
            self.makeLayout(true)
        }
        NotificationCenter.default.addObserver(forName: UITextField.keyboardDidHideNotification, object: nil, queue: .main) { _ in
            UIView.animate(withDuration: 0.35) {
                self.textField.searchIcon.tintColor = .placeholderText
            }
            self.makeLayout(true)
            
        }
    }
    
    func makeLayout(_ animate:Bool = false){
        
        if animate{
            UIView.animate(withDuration: 0.35) {
                self.updateLayout()
                self.layoutIfNeeded()
            }
        }else{
            updateLayout()
        }
    }
    
    func updateLayout(){
       
        if textField.isFirstResponder{
        
            textField.snp.remakeConstraints { make in
                make.top.left.equalToSuperview()
                make.right.equalTo(cancelBtn.snp.left).offset(-8)
                make.bottom.equalToSuperview()
            }
            cancelBtn.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-2)
                make.centerY.equalToSuperview()
                make.width.equalTo(52)
            }
            textField.i_radius = 4
            cancelBtn.alpha = 1
        
            
        }else{
            
            textField.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(2)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-2)
            }
            cancelBtn.snp.makeConstraints { make in
                make.left.equalTo(self.snp.right)
                make.centerY.equalToSuperview()
            }
            textField.i_radius = 8
            cancelBtn.alpha = 0
        }
    }
}

open class ISearchTextField:UITextField{
    lazy var searchIcon: UIImageView = {
        let value = UIImageView()
        value.i_radius = 16
        value.image = .init(systemName: "magnifyingglass")
        value.contentMode = .scaleAspectFit
        value.tintColor = .separator
        return value
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        leftView = searchIcon
        leftViewMode = .always
        placeholder = "输入搜索内容"
        backgroundColor = .tertiarySystemFill
        
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return .init(x: 8, y: 0, width: 20, height: bounds.size.height)
    }
    
    
}
