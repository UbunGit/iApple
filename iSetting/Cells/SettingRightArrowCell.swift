//
//  SettingRightArrowCell.swift
//  MediaBox
//
//  Created by mac on 2022/11/28.
//

import UIKit

class SettingRightArrowCell: UITableViewCell {

   public lazy var valueLab: UILabel = {
        let value = UILabel()
        value.textColor = .black.withAlphaComponent(0.65)
        value.font = .systemFont(ofSize: 14)
        value.textAlignment = .right
        value.text = ">"
        return value
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(valueLab)
        valueLab.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
