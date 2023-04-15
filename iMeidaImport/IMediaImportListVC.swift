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
        value.setTitle("+", for: .normal)
        value.setTitleColor(.red, for: .normal)
        value.setBlockFor(.touchUpInside) {[weak self] _ in
            self?.rightBtnClicked()
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
        navigationItem.rightBarButtonItem = .init(customView: rightBtn)
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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSouce.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.i_dequeueReusableCell(UITableViewCell.self, for: indexPath)
        return cell
    }
    
    
}

