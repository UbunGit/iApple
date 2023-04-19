//
//  EXMeidaInportListVC.swift
//  example
//
//  Created by mac on 2023/4/15.
//

import UIKit
import iApple
class EXMeidaInportListVC: MediaImportListVC<ResourceModel> {

    override func rightBtnClicked() {
        let vc = EXMeidaImportVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.i_registerCell(MediaTableViewCell.self)
        addObserver()
    }
    // 从数据库重新刷新数据
    override func reloadData() {
        super.reloadData()
        DataCenter.share.reloadMedias()
        updateData()
    }
    // 不重新获取数据
    func updateData(){
        dataSouce = DataCenter.share.resources
        tableView.reloadData()
    }

    func addObserver(){
        NotificationCenter.default.addObserver(forName: .mediasDidUpdate, object: nil, queue: .main) {[weak self] _ in
            self?.reloadData()
        }
        NotificationCenter.default.addObserver(forName: .mediasInser, object: nil, queue: .main) {[weak self] notif in
            guard
                let self = self,
                let data = notif.userInfo,
                  let media = data["userInfo"] as? ResourceModel else{
                return
            }
            self.tableView.beginUpdates()
            self.dataSouce.append(media)
            self.tableView.insertRow(at: .init(row: self.dataSouce.count-1, section: 0), with: .automatic)
            self.tableView.endUpdates()
           
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.i_dequeueReusableCell(MediaTableViewCell.self, for: indexPath)
    
        cell.celldata = dataSouce[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = dataSouce[indexPath.row]
        let deleteItem = UIContextualAction(style: .destructive, title: "删除") {  (contextualAction, view, completion) in
            let alert = UIAlertController(title: "删除确认", message: "您是否确定要删除当前资源列表", preferredStyle: .alert)
            alert.addAction(.init(title: "确认删除", style: .default,handler: { _ in
                let celldata = self.dataSouce[indexPath.row]
                tableView.beginUpdates()
                self.dataSouce.remove(at: indexPath.row)
                tableView.deleteRow(at: indexPath, with: .automatic)
                tableView.endUpdates()
                DataCenter.share.delete(data: celldata)
                completion(true)
            }))
            alert.addAction(.init(title: "取消", style: .cancel))
            self.present(alert, animated: true)
        }
        let editItem = UIContextualAction(style: .normal, title: "编辑") {  (contextualAction, view, completion) in
            let vc = EXMeidaImportVC()
            let editdata = EXMeidaImportVC.EditData(id: item.id,name: item.name,url: item.sourceUrl.absoluteString)
            vc.editData = editdata
            self.navigationController?.pushViewController(vc, animated: true)
            completion(true)
        }
        let refreshItem = UIContextualAction(style: .normal, title: "刷新") {  (contextualAction, view, completion) in
            self.refresh(item: item)
            completion(true)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem,editItem,refreshItem])
        
        return swipeActions
    }
    
    func refresh(item:ResourceModel){
     
        RealmAPI.shared.down(url: item.sourceUrl) { response in
            
        }
    }
}

class EXMeidaImportVC:MeidaImportVC{
    override func viewDidLoad() {
        editData.url = "https://raw.githubusercontent.com/Kimentanm/aptv/master/m3u/aptv-playback.m3u"
        super.viewDidLoad()
        
    }
    // 保存
    override func commitDoit() {
       
        guard let urlstr = editData.url,
              let url = URL(string: urlstr) else {
                  UIView.tost(msg: "请输入正确的资源地址")
                  return
              }
        if DataCenter.share.mediasHasItem(url: url){
            let alert = UIAlertController(title: "提示", message: "资源中已包含相同的资源地址，是否继续添加", preferredStyle: .alert)
            alert.addAction(.init(title: "继续添加", style: .default,handler: { _ in
                self.save(url: url)
            }))
            alert.addAction(.init(title: "取消", style: .cancel))
            self.present(alert, animated: true)
            return
        }
       save(url: url)
    }
    
    func save(url:URL){
        DataCenter.share.append(sourceUrl: url, name: editData.name)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
