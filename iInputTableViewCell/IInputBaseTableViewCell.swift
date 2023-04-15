//
//  IInputBaseTableViewCell.swift
//  iApple
//
//  Created by mac on 2023/4/15.
//

import UIKit

open class IInputBaseTableViewCell<T:Any>: UITableViewCell {
    
    public var celldata:T?{
        didSet{
            reloadData()
        }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        makeUI()
        makeLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func makeUI(){
        
    }
    
    open func makeLayout(){
        
    }
    open func reloadData(){
        
    }
}
