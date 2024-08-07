//
//  iFormSelectMonthsCell.swift
//  iPods
//
//  Created by mac on 2023/6/21.
//

import Foundation
open class iFormSelectMonthsCell<T:Any>:IFormBaseCell<T>,I_UICollectionViewProtocol {
    
    lazy var calendar: Calendar = {
        var value = Calendar(identifier: .gregorian)
        let currentLocale = Locale.current
        value.locale = Locale(identifier: currentLocale.identifier)
        return value
    }()
    
    public lazy var days: [String] = {
        calendar.shortMonthSymbols
    }()
    
    public  var selectDays:[Int] = []
    
    public lazy var collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumInteritemSpacing = 4
        flowlayout.minimumLineSpacing = 4
        let value = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        value.delegate = self
        value.dataSource = self
        value.i_register(cellType: ItemCell.self)
        value.backgroundColor = .clear
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
        
        contentView.addSubview(collectionView)
    }
    open override func makeLayout(){
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.left.equalToSuperview().offset(12)
            make.bottom.equalTo(-12)
            make.right.equalToSuperview().offset(-12)
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.i_dequeueReusableCell(with: ItemCell.self, for: indexPath)
        let rowdata = days[indexPath.row]
        cell.titleLab.text = "\(rowdata)"
        let isSelect = selectDays.contains(indexPath.row+1)
        cell.selectImgView.image =  isSelect ? .i_image(name: "week.select") : nil
        return cell
    }
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.cellSize(space: 8, column: 7, ratio: 1/2)
        return .init(width: size.width, height: size.width)
    }
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = indexPath.row+1
        if selectDays.contains(day) {
            selectDays.removeAll { item in
                item == day
            }
        }else{
            selectDays.append(day)
        }
        collectionView.reloadItems(at: [indexPath])
    }
}

extension iFormSelectMonthsCell{
    open class ItemCell:UICollectionViewCell{
        
        public lazy var selectImgView: UIImageView = {
            let value = UIImageView()
            return value
        }()
        public lazy var titleLab: UILabel = {
            let value = UILabel()
            value.numberOfLines = 0
            value.textAlignment = .center
            value.font = .systemFont(ofSize: 14)
            return value
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            makeUI()
            makeLayout()
        }
        
        required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func makeUI(){
            
            layer.cornerRadius = 16
            layer.borderWidth = 0.5
            layer.borderColor = UIColor.systemGroupedBackground.withAlphaComponent(0.35).cgColor
            layer.shadowColor = UIColor.black.withAlphaComponent(0.35).cgColor
            layer.shadowOpacity = 0.5
            layer.shadowOffset = CGSize(width: 0, height: 1)
            layer.shadowRadius = 1
            contentView.addSubview(selectImgView)
            contentView.addSubview(titleLab)
            
        }
        func makeLayout(){
            
            titleLab.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            selectImgView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
}

