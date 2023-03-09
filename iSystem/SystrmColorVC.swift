//
//  SystrmColorVC.swift
//  iApple
//
//  Created by mac on 2023/3/2.
//

import UIKit

public class SystrmColorVC: UIViewController {

    let colors = SystemColor.systemColors
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 8
        let value = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        value.i_register(cellType: ItemCell.self)
        value.delegate = self
        value.dataSource = self
        value.backgroundColor = .tertiarySystemGroupedBackground
        return value
    }()
    public override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
      
    }
    
    func makeUI(){
        title = "系统颜色"
        view.addSubview(collectionView)
    }
    func makeLayout(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        collectionView.reloadData()
    }
}

extension SystrmColorVC:I_UICollectionViewProtocol{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.i_dequeueReusableCell(with: ItemCell.self, for: indexPath)
        let celldata = colors[indexPath.row]
        cell.valueView.backgroundColor = celldata.color
        cell.valueLab.text = celldata.title
        cell.hexLab.text = celldata.color.i_hexString()
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = min((i_screen_w-24)/2, (390-24)/2)
        return .init(width: w, height: w)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    
}

extension SystrmColorVC{
    class ItemCell:UICollectionViewCell{
        
    
        lazy var valueLab: UILabel = {
            let value = UILabel()
            value.textColor = .label
            value.font = UIFont.systemFont(ofSize: 14)
            return value
        }()
        lazy var hexLab: UILabel = {
            let value = UILabel()
            value.textColor = .white
            value.font = UIFont.systemFont(ofSize: 14)
            value.layer.shadowColor = UIColor.black.cgColor
            value.layer.shadowOpacity = 1
            return value
        }()
        lazy var valueView: UIView = {
            let value = UIView()
            return value
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            makeUI()
            makeLayout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func makeUI(){
            backgroundColor = .systemBackground
            contentView.addSubview(valueView)
            contentView.addSubview(valueLab)
            contentView.addSubview(hexLab)
            
        }
        
        func makeLayout(){
            
            valueView.snp.makeConstraints { make in
                make.top.left.equalToSuperview().offset(8)
                make.right.equalToSuperview().offset(-8)
                make.height.equalTo(valueView.snp.width).dividedBy(1.25)
            }
            hexLab.snp.makeConstraints { make in
                make.bottom.equalTo(valueView)
                make.right.equalTo(valueView).offset(-4)
            }
            
            valueLab.snp.makeConstraints { make in
                make.top.equalTo(valueView.snp.bottom).offset(2)
                make.left.equalToSuperview().offset(8)
                make.right.equalToSuperview().offset(-8)
                make.bottom.equalToSuperview().offset(-2)
            }
        }
    }
    
   
}
