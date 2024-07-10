//
//  UITableViewSectionHeader.swift
//  iPods
//
//  Created by mac on 2023/4/3.
//

import UIKit

open class UITableViewSectionMoreHeader: ITableViewSectionBaseHeader {
    
    
    
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
    open override func makeUI(){
        super.makeUI()
        contentView.addSubview(titleLab)
        contentView.addSubview(moreView)
        
    }
    open override func makeLayout(){
        super.makeLayout()
        
        moreView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalTo(titleLab)
            
        }
    }
    
}
