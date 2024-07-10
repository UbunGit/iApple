//
//  VipLaunchViewController.swift
//  iKnead
//
//  Created by admin on 2024/1/15.
//

import UIKit
public struct VIPRights{
    var title:String
}
struct VIPProduct{
    var id:String
    var title:String
    var price:String
    var or_price:String
    var desc:String
}
open class IVipLaunchViewController: IBaseScrollerStackViewController {
  
    public var rights:[VIPRights] = [
        .init(title: "更多的震动模式"),
        .init(title: "更强的震动体验"),
        .init(title: "更多的震动模式"),
        .init(title: "更强的震动体验"),
        .init(title: "更多的震动模式"),
        .init(title: "更强的震动体验"),
    ]
    var selectProduct:VIPProduct!
    var dataSouce:[VIPProduct] = [
        .init(id: "vip_week", title: "1周", price: "¥7.00", or_price: "原价¥7", desc: "不推荐"),
        .init(id: "vip_month", title: "1月", price: "¥28.00", or_price: "原价¥31.00", desc: "省¥3.00"),
        .init(id: "vip_year", title: "1年", price: "¥300.00", or_price: "原价¥365", desc: "省¥65.00"),
        .init(id: "vip_permanent", title: "终身", price: "¥588.00", or_price: "原价¥730", desc: "省¥142.00"),
    ]
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset =  .init(top: 8, left: 12, bottom: 12, right: 12)
        let value = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        value.delegate = self
        value.dataSource = self
        value.backgroundColor = .clear
        value.showsHorizontalScrollIndicator = false
        value.showsVerticalScrollIndicator = false
        value.i_register(cellType: VIPProductsItemView.self)
        return value
    }()
    
    public lazy var headerView: HeaderView = {
        let value = HeaderView()
        value.i_radius = 12
        return value
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        let value = CAGradientLayer()
        value.colors = [UIColor.purple.cgColor,UIColor.blue.cgColor]
        value.locations = [0,0.998]
        value.startPoint = .init(x: 0.5, y: 1)
        value.endPoint = .init(x: 0.5, y: 0)
        return value
    }()
    
   
    
    lazy var freeBtn: CommitBtn = {
        let value = CommitBtn()
        value.i_radius = 24
        value.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        value.setTitle("免费试试", for: .normal)
        return value
    }()
    
    lazy var agreementView: AgreementLinkView = {
        let value = AgreementLinkView()
        return value
    }()
    lazy var remarkLab: UILabel = {
        let value = UILabel()
        value.numberOfLines = 0
        value.font = .systemFont(ofSize: 14, weight: .light)
        value.textColor = .white.withAlphaComponent(0.85)
        value.text = "确认购买后，将向您的iTumes 账户收款。自动续费 iTunes 账户会在到期前 24小时内扣费。在此之前，您可以手动在 iTunes/Apple 1D 设置管理中关闭自动续费。取消续订：苹果手机在 i0s 设备“设置”-> iTunes Store 与 App Store” -> 选择“Apple 1D” -> 点击“查看 Apple ID -> 在账户设置页面点击“订阅”->取消订阅"
        return value
    }()
    
    lazy var tableView: UITableView = {
        let value = UITableView()
        value.delegate = self
        value.dataSource = self
        value.backgroundColor = .clear
        value.i_registerCell(VIPRightsCell.self)
        value.separatorStyle = .none
        value.isScrollEnabled = false
        return value
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        title = "VIP会员"
    }
    
    open override func makeUI() {
        super.makeUI()
        view.layer.insertSublayer(gradientLayer, at: 0)
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(collectionView)
        stackView.addArrangedSubview(freeBtn)
        stackView.addArrangedSubview(agreementView)
        stackView.addArrangedSubview(remarkLab)
        stackView.addArrangedSubview(tableView)
    }
    
    open override func makeLayout() {
        super.makeLayout()
        headerView.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(12)
            make.trailing.equalTo(view).offset(-12)
            
        }
        collectionView.snp.makeConstraints { make in
         
            make.leading.equalTo(view).offset(12)
            make.trailing.equalTo(view).offset(-12)
            make.height.equalTo(168)
        }
        freeBtn.snp.makeConstraints { make in
            make.width.equalTo(270)
            make.height.equalTo(48)
        }
        agreementView.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(12)
            make.trailing.equalTo(view).offset(-12)
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { make in
            let h = rights.count*44
            make.leading.equalTo(view).offset(12)
            make.trailing.equalTo(view).offset(-12)
            make.height.equalTo(h)
            
        }
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
 
}

extension IVipLaunchViewController{
    open class HeaderView:IBaseView{
        open override class var layerClass: AnyClass{
            CAGradientLayer.self
        }
        public lazy var bg: UIView = {
            let value = UIView()
            return value
        }()
        public lazy var imgView: UIImageView = {
            let value = UIImageView()
            return value
        }()
        
        public lazy var titleLab: UILabel = {
            let value = UILabel()
            value.textColor = .white
            value.text = "VIP会员"
            value.font = .systemFont(ofSize: 18, weight: .bold)
            return value
        }()
        
        public lazy var descLab: UILabel = {
            let value = UILabel()
            value.textColor = .white
            value.font = .systemFont(ofSize: 18, weight: .medium)
            value.text = "开通VIP尊享更多权益"
            return value
        }()
        open override func makeUI() {
            super.makeUI()
            addSubview(bg)
            addSubview(imgView)
            addSubview(titleLab)
            addSubview(descLab)
        }
        open override func makeLayout() {
            super.makeLayout()
            imgView.snp.makeConstraints { make in
                make.trailing.equalTo(bg)
                make.top.equalToSuperview()
                make.bottom.equalTo(bg.snp.bottom).offset(-8)
            }
            bg.snp.makeConstraints { make in
                make.trailing.equalTo(-12)
                make.bottom.equalToSuperview()
                make.leading.equalTo(12)
                make.top.equalTo(imgView.snp.bottom).offset(-84)
            }
            titleLab.snp.makeConstraints { make in
                make.leading.equalTo(bg).offset(12)
                make.bottom.equalTo(bg.snp.centerY).offset(-2)
            }
            descLab.snp.makeConstraints { make in
                make.leading.equalTo(titleLab)
                make.top.equalTo(titleLab.snp.bottom).offset(4)
            }
            
        }
        
        open override func layoutSubviews() {
            super.layoutSubviews()
            guard let g_layer = layer as? CAGradientLayer else{return}
            g_layer.colors = [
                UIColor.black.withAlphaComponent(0.35).cgColor,
                UIColor.init(hexString: "#F7CDAE")!.withAlphaComponent(0.35).cgColor,
                UIColor.black.withAlphaComponent(0.35).cgColor,
                UIColor.init(hexString: "#F7CDAE")!.withAlphaComponent(0.35).cgColor,
                UIColor.black.withAlphaComponent(0.35).cgColor,
                UIColor.init(hexString: "#F7CDAE")!.cgColor,
                UIColor.black.withAlphaComponent(0.35).cgColor,
                UIColor.init(hexString: "#F7CDAE")!.cgColor,
                UIColor.black.withAlphaComponent(0.35).cgColor,
                UIColor.init(hexString: "#F7CDAE")!.withAlphaComponent(0.35).cgColor
            ]
            
            g_layer.locations = [0,0.2,0.4,0.6,0.8,0.9,1]
            g_layer.startPoint = .init(x: 0, y: 0.8)
            g_layer.endPoint = .init(x: 1, y: 0.7)
        }
        
    }
}

extension IVipLaunchViewController:I_UICollectionViewProtocol{

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSouce.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.i_dequeueReusableCell(with: VIPProductsItemView.self, for: indexPath)
        let rowData = dataSouce[indexPath.row]
        cell.titleLab.text = rowData.title
        cell.descLab.text = rowData.desc
        cell.priceLab.text = rowData.price
        cell.or_priceLab.text = rowData.or_price
        cell.isSelected = selectProduct?.id == rowData.id
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.cellSize(space: 8, column: 3, ratio: 109.0/158)
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectProduct = dataSouce[indexPath.row]
        UIApplication.shared.i_storePay(proId: selectProduct.id)
    }
    

}

extension IVipLaunchViewController:I_UITableViewProtocol{
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rights.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.i_dequeueReusableCell(VIPRightsCell.self, for: indexPath)
        let rowdata = rights[indexPath.row]
        cell.titleLab.text = rowdata.title
        return cell
    }
}
open class VIPProductsItemView:ICollectionItemCell{
    
    open override class var layerClass: AnyClass{
        CAGradientLayer.self
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        i_radius = 12
        stackView.spacing = 8
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public lazy var priceLab: UILabel = {
        let value = UILabel()
        value.textAlignment = .center
        value.font = .systemFont(ofSize: 18, weight: .bold)
        value.textColor = .init(hexString: "#652906")
        return value
    }()
    // 原价
    public lazy var or_priceLab: UILabel = {
        
        let value = UILabel()
        value.textColor = .init(hexString: "#652906")
        value.font = .systemFont(ofSize: 14, weight: .medium)
        value.textAlignment = .center
        let line = UIView()
        line.backgroundColor = .white.withAlphaComponent(0.35)
        value.addSubview(line)
        line.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
            make.centerY.equalToSuperview()
        }
        return value
    }()
    public lazy var descLab: UILabel = {
        let value = UILabel()
        value.textColor = .init(hexString: "#652906")
        value.i_radius = 12
        value.font = .systemFont(ofSize: 12, weight: .medium)
        value.textAlignment = .center
        value.backgroundColor = .black.withAlphaComponent(0.35)
        return value
    }()
    open override func makeUI() {
        contentView.addSubview(stackView)
        titleLab.textColor = .init(hexString: "#652906")
        titleLab.font = .systemFont(ofSize: 18, weight: .bold)
        let top = UIView()
        stackView.addArrangedSubview(top)
        stackView.addArrangedSubview(titleLab)
        stackView.addArrangedSubview(priceLab)
        stackView.addArrangedSubview(or_priceLab)
        stackView.addArrangedSubview(descLab)
        let bottomView = UIView()
        stackView.addArrangedSubview(bottomView)
        top.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(12)
        }
        bottomView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(12)
        }
    }
    open override func makeLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        descLab.snp.makeConstraints { make in
            
            make.width.equalTo(self).offset(-34)
            make.height.equalTo(22)
        }
    }
    open override var isSelected: Bool{
        didSet{
            if !isSelected{
                titleLab.textColor = .init(hexString: "#828FA0")
                descLab.textColor =  .init(hexString: "#828FA0")
                priceLab.textColor =  .init(hexString: "#828FA0")
                or_priceLab.textColor =  .init(hexString: "#828FA0")
            }else{
                titleLab.textColor = .init(hexString: "#652906")
                descLab.textColor =  .init(hexString: "#652906")
                priceLab.textColor =  .init(hexString: "#652906")
                or_priceLab.textColor =  .init(hexString: "#652906")
            }
            
            layoutIfNeeded()
        }
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        guard let g_layer = layer as? CAGradientLayer else{return}
        g_layer.locations = [0.2,1]
        g_layer.startPoint = .init(x: 0.5, y: 1)
        g_layer.endPoint = .init(x: 0.5, y: 0)
        if isSelected{
            g_layer.colors = [
                UIColor.init(hexString: "#F7CDAE")!.cgColor,
                UIColor.init(hexString: "#F2E6D5")!.cgColor,
            ]
        }
        else{
            g_layer.colors = [
                UIColor.black.cgColor,
                UIColor.black.withAlphaComponent(0.15).cgColor,
            ]
        }

    }
    
    
}

open class VIPRightsCell:ISimpleTableCell{
    
   
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        iconView.image = .i_image(name: "hand.point.right.fill")
        iconView.tintColor = .purple
        titleLab.textColor = .white
        valueLab.isHidden = true
        moreArrow.isHidden = true
        titleLab.font = .systemFont(ofSize: 18, weight: .regular)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public lazy var priceLab: UILabel = {
        let value = UILabel()
        value.textAlignment = .center
        value.font = .systemFont(ofSize: 18, weight: .bold)
        value.textColor = .init(hexString: "#652906")
        return value
    }()
 
    public lazy var descLab: UILabel = {
        let value = UILabel()
        value.textColor = .init(hexString: "#652906")
        value.i_radius = 12
        value.font = .systemFont(ofSize: 12, weight: .medium)
        value.textAlignment = .center
        value.backgroundColor = .black.withAlphaComponent(0.35)
        return value
    }()
    open override func makeUI() {
        super.makeUI()
        
    }
    open override func makeLayout() {
       super.makeLayout()
    }

    
    
}
