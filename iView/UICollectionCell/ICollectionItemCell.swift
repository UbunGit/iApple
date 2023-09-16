//
//  CollectionItemCell.swift
//  iApple
//
//  Created by admin on 2023/8/10.
//

import Foundation
import UIKit
open class ICollectionItemCell: UICollectionViewCell {
    lazy var stackView: UIStackView = {
        let value = UIStackView()
        value.axis = .vertical
        value.spacing  = 4
        return value
    }()
    public lazy var titleLab: UILabel = {
        let value = UILabel()
        value.textAlignment = .center
        value.font = .systemFont(ofSize: 12, weight: .regular)
        value.textColor = .secondaryLabel
        return value
    }()
    public lazy var imageView: UIImageView = {
        let value = UIImageView()
        value.i_radius = 0.1
        value.contentMode = .scaleAspectFit
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
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLab)
    
    }
    open func makeLayout(){
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
    }
}
