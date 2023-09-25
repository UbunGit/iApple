//
//  ViewController.swift
//  EXIAD
//
//  Created by admin on 2023/9/18.
//

import UIKit
import iApple
class ViewController: IBaseViewController {

    var dataSouce:[CellItem] = [.csj_splash,.csj_rewarded,.google_splash,.google_rewarded]
    lazy var tableview: UITableView = {
        let value = UITableView()
        value.i_registerCell(UITableViewCell.self)
        value.dataSource = self
        value.delegate = self
        return value
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        ADManage.share.setUp()
        
    }
    override func makeUI() {
        super.makeUI()
        view.addSubview(tableview)
    }
    override func makeLayout() {
        super.makeLayout()
        tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }


}
extension ViewController:I_UITableViewProtocol{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSouce.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.i_dequeueReusableCell(UITableViewCell.self, for: indexPath)
        let rowData = dataSouce[indexPath.row]
        cell.textLabel?.text = rowData.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowData = dataSouce[indexPath.row]
        switch rowData{
        case .csj_splash:
            self.csj_showSplash { state in
                debugPrint(state)
            }
        case .google_splash:
            self.googel_showSplash { state in
                debugPrint(state)
            }
        case .csj_rewarded:
            self.csj_showRewarded { state in
                debugPrint(state)
            }
        case .google_rewarded:
            self.googel_showRewarded{ state in
                debugPrint(state)
            }
        }
    }
}

extension ViewController{
    enum CellItem{
        case csj_splash
        case google_splash
        case csj_rewarded
        case google_rewarded
        
        var title:String{
            switch self{
            case .csj_splash:
                return "穿山甲开屏"
            case .google_splash:
                return "谷歌开屏"
            case .csj_rewarded:
                return "穿山甲激励"
            case .google_rewarded:
                return "谷歌激励"
            }
       
            
        }
    }
}

