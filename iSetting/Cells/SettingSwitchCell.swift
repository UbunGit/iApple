//
//  SettingSwitchCell.swift
//  MediaBox
//
//  Created by mac on 2022/11/28.
//

import UIKit

class SettingSwitchCell: UITableViewCell {

    lazy var switchView: UISwitch = {
        let value = UISwitch()
        return value
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(switchView)
        switchView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
