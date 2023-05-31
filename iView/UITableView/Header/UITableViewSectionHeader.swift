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
    public lazy var moreView: UIButton = {
        let value = UIButton()
        value.setImage(UIImage(systemName: "ellipsis"), for: .normal)
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
    open func makeUI(){
  
        contentView.addSubview(titleLab)
        contentView.addSubview(moreView)
      
    }
    open func makeLayout(){
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
