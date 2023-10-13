//
//  ITableViewSectionBaseHeader.swift
//  iApple
//
//  Created by admin on 2023/10/8.
//

import Foundation
open class ITableViewSectionBaseHeader: UITableViewHeaderFooterView {


    public lazy var titleLab: UILabel = {
        let value = UILabel()
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
     
      
    }
    open func makeLayout(){
        titleLab.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
       
    }
    
}
