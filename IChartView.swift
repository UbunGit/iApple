//
//  IChartView.swift
//  iApple
//
//  Created by admin on 2023/7/30.
//

import UIKit

open class IChartView: UIView {
   
    public lazy var contentView = UIScrollView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func makeUI(){
        addSubview(contentView)
    }
    public func makeLayout(){
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    } 
}
