//
//  MediaImportListVC.swift
//  example
//
//  Created by mac on 2023/4/15.
//

import UIKit

open class MediaImportListVC<T>: UIViewController,I_UITableViewProtocol {

    public var dataSouce:[T] = []
    public lazy var searchContainer: UISearchController = {
        let value = UISearchController()
        return value
    }()
    public lazy var rightBtn: UIButton = {
        let value = UIButton()
        value.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        value.setTitleColor(.red, for: .normal)
        value.setBlockFor(.touchUpInside) {[weak self] _ in
            self?.rightBtnClicked()
        }
        return value
    }()
    public lazy var editBtn: UIButton = {
        let value = UIButton()
        value.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
//        value.setTitle(nil, for: .normal)
//        
//        value.setTitle("完成", for: .selected)
//        value.setImage(nil, for: .selected)
//      
//        value.isSelected = true
        value.setBlockFor(.touchUpInside) {[weak self] _ in
            self?.editBtnClicked()
        }
        return value
    }()
    
   public lazy var tableView: UITableView = {
        let value = UITableView()
        value.delegate = self
        value.dataSource = self
        value.i_registerCell(UITableViewCell.self)
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
      
        makeUI()
        makeLayout()
        reloadData()
        
    }
    open func makeUI(){
        title = "导入"
        navigationItem.rightBarButtonItems = [.init(customView: rightBtn),.init(customView: editBtn)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.searchController = searchContainer
        view.addSubview(tableView)
    }
    
    open func makeLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    open func reloadData(){
        
    }
    
    open func rightBtnClicked(){
        let vc = MeidaImportVC()
        self.navigationController?.pushViewController( vc, animated: true)
    }
    open func editBtnClicked(){
        editBtn.isSelected.toggle()
        tableView.isEditing.toggle()
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSouce.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.i_dequeueReusableCell(UITableViewCell.self, for: indexPath)
        return cell
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    open func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let celldata = dataSouce[indexPath.row]
            dataSouce.remove(at: indexPath.row)
            tableView.deleteRow(at: indexPath, with: .automatic)

           
            return
            
        }
        
    }
    
}

