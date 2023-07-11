//
//  CollectionWithMoreBtnHeader.swift
//  iApple
//
//  Created by mac on 2023/6/21.
//

import UIKit

open class CollectionWithMoreBtnHeader: CollectionBaseHeader {

    public lazy var moreBtn: UIButton = {
        let value = UIButton()
        value.setTitle("按周", for: .normal)
        value.setTitleColor(.secondaryLabel, for: .normal)
        value.titleLabel?.font = .boldSystemFont(ofSize: 14)
        value.setImage(.i_image(name: "chevron.forward")?.byResize(to: .init(width: 12, height: 12)), for: .normal)
        value.setEdgeInsets(with: .trailing, space: 2)
        value.tintColor = .systemGroupedBackground
        return value
    }()
    override open func makeUI() {
        super.makeUI()
        titleLab.text = "频率"
        addSubview(moreBtn)
    }
    override open func makeLayout() {
        super.makeLayout()
        moreBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
        }
    }
}

