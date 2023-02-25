//
//  ViewController.swift
//  example
//
//  Created by mac on 2023/2/25.
//

import UIKit
import iApple
import SnapKit
class ViewController: UIViewController {

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
        title = "iApple"
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
extension ViewController:I_UITableViewProtocol{
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
        guard let vc = UIViewController.i_initWith(urlStr: celldata.vcurl) else { return  }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController{
    struct CellData{
        var title:String
        var content:String
        var vcurl:String
        
        static let cellDatas:[ViewController.CellData] = [
            .init(title: "IAD",content: "聚合 穿山甲 与 google ADMob 的广告调用",vcurl:"app://ad.home")
        ]
    }
    
}


