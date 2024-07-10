//
//  CollectionButtonCell.swift
//  iPods
//
//  Created by admin on 2023/8/10.
//

import Foundation
import UIKit
open class ICollectionButtonCell: UICollectionViewCell {
    public lazy var button: UIButton = {
        let value = UIButton()
        value.setTitle("默认", for: .normal)
        value.titleLabel?.font = .systemFont(ofSize: 12)
        value.setImage(.i_image(name: "tray.full.fill"), for: .normal)
        value.setEdgeInsets(with: .top, space: 4)
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
    open func makeUI(){
        addSubview(button)
    }
    open func makeLayout(){
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
