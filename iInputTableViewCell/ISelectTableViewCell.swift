//
//  ISelectTableViewCell.swift
//  iApple
//
//  Created by admin on 2023/5/15.
//

import UIKit

open class ISelectTableViewCell<T:Any>: IInputBaseTableViewCell<T> {
 
    public lazy var titleLab: UILabel = {
        let value = UILabel()
        value.text = "选择性别"
        value.textAlignment = .center
        return value
    }()
   public lazy var moreIcon: UIImageView = {
        let value = UIImageView()
        value.image =  UIImage(systemName: "chevron.right")
        return value
    }()
    open override func makeUI() {
        contentView.addSubview(titleLab)
        contentView.addSubview(moreIcon)
    }
    open override func makeLayout() {
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(82)
        }
        moreIcon.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
    }

}
