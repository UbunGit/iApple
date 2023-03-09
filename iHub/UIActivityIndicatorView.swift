//
//  UIActivityIndicatorView.swift
//  MediaBox
//
//  Created by mac on 2022/11/28.
//

import Foundation

open class UGActivityIndicatorView:UIActivityIndicatorView{
    public lazy var titleLab: UILabel = {
        let value = UILabel()
        value.textAlignment = .center
        value.textColor = self.color
        value.font = .systemFont(ofSize: 8)
        return value
    }()
    
    required public override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
