//
//  TitleTextFieldView.swift
//  Alamofire
//
//  Created by mac on 2023/6/19.
//

import UIKit
import IQKeyboardManagerSwift

open class TitleTextFieldView: UIView {

    public lazy var titleLab: UILabel = {
        let value = UILabel()
        value.font = .boldSystemFont(ofSize: 14)
        return value
    }()
    public lazy var textField: IKitTextField = {
        let value = IKitTextField()
        value.leftView = UIView()
        value.leftViewRectBlock = { _ in
            return .init(x: 0, y: 0, width: 12, height: 0)
        }
        value.i_radius = 12
        value.backgroundColor = .systemGroupedBackground
        return value
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI(){
        addSubview(titleLab)
        addSubview(textField)
    }
    func makeLayout(){
        titleLab.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.bottom.equalTo(textField.snp.top).offset(-8)
            make.height.equalTo(12)
        }
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
           
        }
    }
    

}


open class TitleTextView: UIView {

    public lazy var titleLab: UILabel = {
        let value = UILabel()
        value.font = .boldSystemFont(ofSize: 14)
        return value
    }()
    public lazy var textView: IQTextView = {
        let value = IQTextView()
        value.font = .systemFont(ofSize: 16)
        value.i_radius = 12
        value.backgroundColor = .systemGroupedBackground
        return value
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI(){
        addSubview(titleLab)
        addSubview(textView)
    }
    func makeLayout(){
        titleLab.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.bottom.equalTo(textView.snp.top).offset(-8)
            make.height.equalTo(12)
        }
        textView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
           
        }
    }
    

}
