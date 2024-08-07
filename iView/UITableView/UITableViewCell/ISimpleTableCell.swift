//
//  ISimpleTableCell.swift
//  iPods
//
//  Created by mac on 2023/3/1.
//

import Foundation
import SwiftUI
import UIKit
import SnapKit

open class ISimpleTableCell: UITableViewCell {

    public lazy var iconView: UIImageView = {
        let value = UIImageView()
        value.image = .init(systemName: "trophy.fill")
        value.contentMode = .scaleAspectFit
        return value
        
    }()
    public lazy var titleLab: UILabel = {
        let value = UILabel()
        value.text = "升级Pro"
        value.font = .systemFont(ofSize: 16)
        value.textColor = .label
        return value
    }()
    
    lazy var leftStackView: UIStackView = {
        let value = UIStackView()
        value.spacing = 4
        return value
    }()
    
    lazy var rightStackView: UIStackView = {
        let value = UIStackView()
        value.spacing = 4
        return value
    }()
    
    public lazy var valueLab: UILabel = {
        let value = UILabel()
        value.text = "了解更多"
        value.numberOfLines = 0
        value.textColor = .secondaryLabel
        value.font = .systemFont(ofSize: 14)
        return value
    }()
    
    public lazy var moreArrow: UIImageView = {
        let value = UIImageView()
        value.image = .init(systemName: "chevron.right")
        value.tintColor = .quaternaryLabel
        return value
        
        
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeUI()
        makeLayout()
        selectionStyle = .none
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func makeUI(){
        addSubview(leftStackView)
        addSubview(rightStackView)
        leftStackView.addArrangedSubview(iconView)
        leftStackView.addArrangedSubview(titleLab)
       
        rightStackView.addArrangedSubview(valueLab)
        rightStackView.addArrangedSubview(moreArrow)
    }
    
    open func makeLayout(){
        leftStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
       
        rightStackView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
      
        }
//        titleLab.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.equalTo(iconView.snp.right).offset(12)
//        }
//        valueLab.snp.makeConstraints { make in
//            make.right.equalTo(moreArrow.snp.left).offset(-12)
//            make.centerY.equalToSuperview()
//        }
        
    }
    
  

}

struct ISimpleTableCellWarp:UIViewRepresentable{
  
    
    func makeUIView(context: Context) -> ISimpleTableCell {
        let view = ISimpleTableCell()
        return view
    }
    func updateUIView(_ uiView: ISimpleTableCell, context: Context) {
        
    }
}
@available(iOS, introduced: 15.0)
struct ISimpleTableCell_Previews:PreviewProvider{
    static var previews: some View {
        
        ISimpleTableCellWarp()
            .background(.quaternary)
    }
    
}
