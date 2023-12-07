//
//  ViewController.swift
//  EXIAD
//
//  Created by admin on 2023/9/18.
//

import UIKit
import iApple
class ViewController: IBaseViewController {

    var dataSouce:[CellItem] = CellItem.allCases
    lazy var tableview: UITableView = {
        let value = UITableView()
        value.i_registerCell(UITableViewCell.self)
        value.dataSource = self
        value.delegate = self
        return value
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        IADConfig.shared.csj_appID = "5434419"
        IADConfig.shared.csj_splashID = "888691906"
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
        let msg = """
CSJ_APPID:\(IADConfig.shared.csj_appID.i_string())
CSJ_splashID:\(IADConfig.shared.csj_splashID.i_string())
CSJ_rewardedID:\(IADConfig.shared.csj_rewardedID.i_string())

Google_splashID:\(IADConfig.shared.google_splashID.i_string())
Google_rewardedID:\(IADConfig.shared.google_rewardedID.i_string())
"""
        let alert = UIAlertController(title: "广告配置", message: msg, preferredStyle: .alert)
        alert.addAction(.init(title: "确定", style: .default, handler: { _ in
            let rowData = self.dataSouce[indexPath.row]
            self.next(item: rowData)
        }))
        alert.addAction(.init(title: "取消", style: .cancel))
        self.present(alert, animated: true)
        
        
    }
    
    func next(item:CellItem){
        switch item{
        case .csj_splash:
            
            self.csj_showSplash { state in
                debugPrint(state)
            }
        case .google_splash:
            self.googel_showSplash { state in
                debugPrint(state)
            }
        case .csj_rewarded:
            IADConfig.shared.csj_splashID = "954642524"
            self.csj_showRewarded { state in
                debugPrint(state)
            }
        case .google_rewarded:
            self.googel_showRewarded{ state in
                debugPrint(state)
            }
        case .auto_splash:
            self.auto_showSplash { state in
                debugPrint(state)
            }
        case .roll_splash:
            self.roll_showSplash { state in
                debugPrint(state)
            }
        case .splash:
            self.showSplash { state in
                debugPrint(state)
            }
        case .auto_rewarded:
            self.auto_showRewarded  { state in
                debugPrint(state)
            }
        case .roll_rewarded:
            self.roll_showRewarded  { state in
                debugPrint(state)
            }
        case .rewarded:
            self.showRewarded  { state in
                debugPrint(state)
            }
        }
    }
}

extension ViewController{
    enum CellItem:CaseIterable{
        case csj_splash
        case google_splash
        case auto_splash
        case roll_splash
        case splash
        
        case csj_rewarded
        case google_rewarded
        case auto_rewarded
        case roll_rewarded
        case rewarded
        
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
            case .auto_splash:
                return  "自动开屏"
            case .roll_splash:
                return "轮动开屏"
            case .splash:
                return "按配置开屏"
            case .auto_rewarded:
                return "自动激励"
            case .roll_rewarded:
                return "滚动激励"
            case .rewarded:
                return "按配置激励"
            }
        }
    }
}

