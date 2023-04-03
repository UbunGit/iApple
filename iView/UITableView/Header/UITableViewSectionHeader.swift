//
//  UITableViewSectionHeader.swift
//  iApple
//
//  Created by mac on 2023/4/3.
//

import UIKit

open class UITableViewSectionHeader: UITableViewHeaderFooterView {
    
    public lazy var titleLab: UILabel = {
        let value = UILabel()
        return value
    }()
    public lazy var moreView: UIImageView = {
        let value = UIImageView()
        value.image = UIImage(systemName: "ellipsis")
        return value
    }()
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        makeUI()
        makeLayout()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func makeUI(){
        addSubview(titleLab)
        addSubview(moreView)
    }
    public func makeLayout(){
        titleLab.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        moreView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(titleLab)
        }
    }
    
}
