//
//  ISelectTimeCell.swift
//  iPods
//
//  Created by mac on 2023/6/20.
//

import Foundation
import PGDatePicker

open class IFormSelectTimeCell<T:Any>:IFormBaseCell<T>,PGDatePickerDelegate{
   public lazy var titleLab: UILabel = {
        let value = UILabel()
        value.font = .boldSystemFont(ofSize: 14)
        value.text = "时间"
        return value
    }()
    public lazy var datePick: PGDatePicker = {
        let value = PGDatePicker()
        value.datePickerMode = .time
        value.textFontOfOtherRow = .systemFont(ofSize: 14)
        value.textFontOfSelectedRow = .boldSystemFont(ofSize: 24)
        value.textColorOfSelectedRow = .label
        value.datePickerType = .segment
        value.lineBackgroundColor = .systemGroupedBackground
        value.delegate = self
        value.autoSelected = true
        return value
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeUI()
        makeLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func makeUI(){
        contentView.addSubview(titleLab)
        contentView.addSubview(datePick)
    }
    open override func makeLayout(){
        titleLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(32)
        }
        
        datePick.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom)
            make.left.equalToSuperview().offset(12)
            make.bottom.equalTo(-12)
            make.right.equalToSuperview().offset(-12)
        }
    }
    open func datePicker(_ datePicker: PGDatePicker!, didSelectDate dateComponents: DateComponents!) {
        
    }

}
