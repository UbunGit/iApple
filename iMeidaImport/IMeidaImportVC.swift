//
//  MeidaImportVC.swift
//  example
//
//  Created by mac on 2023/4/15.
//

import UIKit

import IQKeyboardManagerSwift

open class MeidaImportVC: UIViewController,I_UITableViewProtocol {

    public var editData = EditData(id: UUID().uuidString)
    
    var dataSouce:[CellGroup] = [
        .init(name: "资源信息", items: [
            .meidaName,.meidaUrl
        ])
    ]
    
    lazy var rightBtn: UIButton = {
        let value = UIButton()
        value.setTitle("保存", for: .normal)
        value.setTitleColor(.red, for: .normal)
        value.setBlockFor(.touchUpInside) {[weak self] _ in
            self?.commitDoit()
        }
        return value
    }()
  
    lazy var tableView: UITableView = {
        let value = UITableView.init(frame: .zero, style: .insetGrouped)
        value.i_registerCell(NameCell.self)
        value.i_registerCell(UrlCell.self)
        
        value.dataSource = self
        value.delegate = self
        return value
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
    }
    
    func makeUI(){
        navigationItem.rightBarButtonItem = .init(customView: rightBtn)
        view.addSubview(tableView)
    }
    
    func makeLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    open func commitDoit(){
        
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataSouce.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = dataSouce[section]
        return sectionData.items.count
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionData = dataSouce[indexPath.section]
        let celldata = sectionData.items[indexPath.row]
        switch celldata{
        case .meidaName:
           return  NameCell.cellHeight
        case .meidaUrl:
            return  UrlCell.cellHeight
     
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionData = dataSouce[indexPath.section]
        let celldata = sectionData.items[indexPath.row]
        switch celldata{
        case .meidaName:
            let cell = tableView.i_dequeueReusableCell(NameCell.self, for: indexPath)
            cell.celldata = editData
            return cell
        case .meidaUrl:
            let cell = tableView.i_dequeueReusableCell(UrlCell.self, for: indexPath)
            cell.celldata = editData
            return cell
     
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionData = dataSouce[section]
        return sectionData.name
    }
}


extension MeidaImportVC{
    @objcMembers
    public class EditData:NSObject{
        public var id:String
        public  var name:String?
        public  var url:String?
        public init(id: String, name: String? = nil, url: String? = nil) {
            self.id = id
            self.name = name
            self.url = url
        }
    }
    
    public struct CellGroup{
        var name:String
        var items:[CellData]
    }
    public enum CellData:Int{
        case meidaName
        case meidaUrl
    }
    
    public class NameCell:IInputTextFieldCell<EditData>{
        static let cellHeight:CGFloat = 84
        lazy var nameLab: UILabel = {
            let value = UILabel()
            value.font = .systemFont(ofSize: 14)
            value.textColor = .label
            return value
        }()
        public override func makeUI() {
            super.makeUI()
            nameLab.text = "资源名称"
            contentView.addSubview(nameLab)
        }
        public override func makeLayout() {
            nameLab.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.top.equalToSuperview()
                make.height.equalTo(32)
            }
            textField.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.top.equalTo(nameLab.snp.bottom)
            }
            
        }
        public override func reloadData() {
            textField.text = celldata?.name
            
        }
    }
    public class UrlCell:IInputTextViewCell<EditData>{
        static let cellHeight:CGFloat = 128
        lazy var nameLab: UILabel = {
            let value = UILabel()
            value.font = .systemFont(ofSize: 14)
            value.textColor = .label
            return value
        }()
        public override func makeUI() {
            super.makeUI()
            nameLab.text = "资源url地址(必填)"
            contentView.addSubview(nameLab)
        }
        public override func reloadData() {
            
            textView.text = celldata?.url
        }
        public override func makeLayout() {
            nameLab.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.top.equalToSuperview()
                make.height.equalTo(32)
            }
            textView.snp.remakeConstraints { make in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.top.equalTo(nameLab.snp.bottom)
            }
            
        }
       
    }
}
