//
//  CollectionBaseHeader.swift
//  Alamofire
//
//  Created by mac on 2023/4/20.
//

import UIKit

open class CollectionBaseHeader: UICollectionReusableView {
   public lazy var titleLab: UILabel = {
        let value = UILabel()
        value.font = .boldSystemFont(ofSize: 14)
        value.textColor = .label
        return value
    }()
    public lazy var gradientView: GradientView = {
        let value = GradientView()
        value.horizontalMode = true
        value.i_radius = 2
        return value
    }()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI(){
        addSubview(gradientView)
        addSubview(titleLab)
    }
    func makeLayout(){
        gradientView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview()
            make.width.equalTo(titleLab).offset(4)
        }
        titleLab.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
    }
}
