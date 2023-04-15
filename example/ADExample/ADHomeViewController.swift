//
//  ADHomeViewController.swift
//  example
//
//  Created by mac on 2023/2/25.
//

import UIKit
import iApple
class ADHomeViewController: UIViewController {

    var dataSouce = CellData.cellDatas
    
    lazy var tableview: UITableView = {
        let value = UITableView()
        value.dataSource = self
        value.delegate = self
        value.i_registerCell(UITableViewCell.self)
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iAD"
        makeUI()
        makeLayout()
    }
    
    func makeUI(){
        view.addSubview(tableview)
    }
    func makeLayout(){
        tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
extension ADHomeViewController:I_UITableViewProtocol{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSouce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.i_dequeueReusableCell(UITableViewCell.self, for: indexPath)
        let celldata = dataSouce[indexPath.row]
        cell.textLabel?.text = celldata.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let celldata = dataSouce[indexPath.row]
        self.perform(.init(celldata.handle))
       
    }
    
}



extension ADHomeViewController{
    struct CellData{
        var title:String
        var content:String
        var handle:String
        
        static let cellDatas:[ADHomeViewController.CellData] = [
            .init(title: "开屏广告",content: "",handle: "showSplash"),
            .init(title: "激励广告",content: "",handle: "showRewarded")
        ]
        
    }
    @objc func showSplash(){
        self.showSplash { state in
            
        }
       
    }
    @objc func showRewarded(){
        self.showRewarded(isAlert: true, fineshBlock: { state in
            
        })
       
    }
    
}

