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
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        }
   
        let celldata = dataSouce[indexPath.row]
        cell!.textLabel?.text = celldata.title
        cell!.detailTextLabel?.text = celldata.content
        return cell!
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
            .init(title: "IAD",content: "聚合 穿山甲 与 google ADMob 的广告调用", vcurl: VCRouter.adhome),
            .init(title: "媒体导入",content: "根据url导入媒体文件", vcurl: VCRouter.mediaImportList),
        ]
    }
    
}


