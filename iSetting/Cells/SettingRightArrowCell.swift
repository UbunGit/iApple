//
//  SettingRightArrowCell.swift
//  MediaBox
//
//  Created by mac on 2022/11/28.
//

import UIKit

open class SettingRightArrowCell: UITableViewCell {

   public lazy var valueLab: UILabel = {
        let value = UILabel()
        value.textColor = .secondaryLabel
        value.font = .systemFont(ofSize: 14)
        value.textAlignment = .right
        value.text = ">"
        return value
    }()
    lazy var arrowImgView: UIImageView = {
        let value = UIImageView()
        value.image = .i_image(name: "chevron.right")
        value.tintColor = .secondaryLabel
        return value
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        makeUI()
        makeLayout()
    }
    
    public func makeUI(){
        contentView.addSubview(valueLab)
        contentView.addSubview(arrowImgView)
    }
    public func makeLayout(){
        valueLab.snp.makeConstraints { make in
            make.right.equalTo(arrowImgView.snp.left).offset(-4)
            make.centerY.equalToSuperview()
        }
        arrowImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
