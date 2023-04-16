//
//  MediaTableViewCell.swift
//  example
//
//  Created by admin on 2023/4/16.
//

import UIKit
import iApple

class MediaTableViewCell: UITableViewCell {

    var celldata:ResourceModel!{
        didSet{
            reloadData()
        }
    }
    
    lazy var nameLab: UILabel = {
        let value = UILabel()
        return value
    }()
    lazy var descLab: UILabel = {
        let value = UILabel()
        return value
    }()
    lazy var urlLab: UILabel = {
        let value = UILabel()
        return value
    }()
    lazy var lastUpdateDataLab: UILabel = {
        let value = UILabel()
        return value
    }()
    lazy var stateImgView: UIImageView = {
        let value = UIImageView()
        return value
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeUI()
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI(){
        contentView.addSubview(nameLab)
        contentView.addSubview(descLab)
        contentView.addSubview(urlLab)
        contentView.addSubview(lastUpdateDataLab)
        contentView.addSubview(stateImgView)
    }
    
    func makeLayout(){
        nameLab.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
        }
        descLab.snp.makeConstraints { make in
            make.top.equalTo(nameLab.snp.bottom).offset(4)
            make.left.equalTo(nameLab)
        }
        urlLab.snp.makeConstraints { make in
            make.top.equalTo(descLab.snp.bottom).offset(4)
            make.left.equalTo(nameLab)
        }
        
        stateImgView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.centerY).offset(-2)
            make.right.equalToSuperview().offset(-16)
        }
        lastUpdateDataLab.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.centerY).offset(2)
            make.right.equalTo(stateImgView)
        }
    }

}

extension MediaTableViewCell{
    func reloadData(){
        nameLab.text = celldata.name
        urlLab.text = celldata.sourceUrl.absoluteString
        lastUpdateDataLab.text = Date().i_dateString()
    }
}
