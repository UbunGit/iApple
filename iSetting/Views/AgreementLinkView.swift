//
//  PrivateLinkUrl.swift
//  iApple
//
//  Created by admin on 2024/1/16.
//

import Foundation
open class AgreementLinkView:UIStackView{
    
    public var userurl:String = "https://homewh.chaoxing.com/agree/userAgreement"
    public var privateurl:String = "https://www.julyedu.com/agreement/priv"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        alignment = .trailing
        spacing = 12
        addArrangedSubview(userAgreementBtn)
        addArrangedSubview(privateAgreementBtn)
    }
    
    public lazy var userAgreementBtn: UIButton = {
        let value = UIButton()
        value.setTitle("用户使用协议", for: .normal)
        value.setTitleColor(.white, for: .normal)
        value.font = .systemFont(ofSize: 14, weight: .medium)
        value.setBlockFor(.touchUpInside) { [weak self] _ in
            guard let self = self,
                  let url = URL.init(string: self.userurl) else{return}
            UIApplication.shared.open(url)
        }
        return value
    }()
    public lazy var privateAgreementBtn: UIButton = {
        let value = UIButton()
        value.setTitle("隐私协议", for: .normal)
        value.setTitleColor(.white, for: .normal)
        value.font = .systemFont(ofSize: 14, weight: .medium)
        value.setBlockFor(.touchUpInside) { [weak self] _ in
            guard let self = self,
                  let url = URL.init(string: self.privateurl) else{return}
            UIApplication.shared.open(url)
        }
        return value
    }()
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
