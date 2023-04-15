//
//  EXMeidaInportListVC.swift
//  example
//
//  Created by mac on 2023/4/15.
//

import UIKit
import iApple
class EXMeidaInportListVC: MediaImportListVC<MediaModel> {

    override func rightBtnClicked() {
        let vc = EXMeidaImportVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func reloadData() {
        super.reloadData()
        DataCenter.share.reloadMedias()
        dataSouce = DataCenter.share.medias
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let celldata = dataSouce[indexPath.row]
        cell.textLabel?.text = celldata.sourceUrl.absoluteString
        return cell
    }
}

class EXMeidaImportVC:MeidaImportVC{
    override func viewDidLoad() {
        editData.url = "https://www.baidu.com"
        super.viewDidLoad()
        
    }
    // 保存
    override func commitDoit() {
        guard let urlstr = editData.url,
              let url = URL(string: urlstr) else {
                  UIView.tost(msg: "请输入正确的资源地址")
                  return
              }
        
        DataCenter.share.append(sourceUrl: url, name: editData.name)
    }
}
