//
//  SettingViewController.swift
//  MediaBox
//
//  Created by mac on 2022/11/28.
//

import UIKit
import SDWebImage
import StoreKit
open class SettingViewController: UIViewController {
    
    var email:String = "we2657932@163.com"
    var dataSouce = CellType.allCases
    lazy var tableView: UITableView = {
        let value = UITableView()
        value.delegate = self
        value.dataSource = self
        value.registerCell(UITableViewCell.self)
        value.registerCell(SettingSwitchCell.self)
        value.registerCell(SettingRightArrowCell.self)
        
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        title = "关于"
        makeUI()
        makeLayout()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    func makeUI(){
        view.addSubview(tableView)
    }
    
    func makeLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SettingViewController:UITableViewProtocol{
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return CellType.allCases.count
        default:
            return 0
        }
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(SettingSwitchCell.self, for: indexPath)
            cell.textLabel?.text = "智能高清图片"
            cell.switchView.isOn = isHigh
            cell.switchView.setBlockFor(.valueChanged) { _ in
                self.isHigh.toggle()
                tableView.reloadData()
            }
            return cell
        case 1:
         
            let cell = tableView.dequeueReusableCell(SettingRightArrowCell.self, for: indexPath)
            cell.textLabel?.text = CellType.allCases[indexPath.row].title
            cell.valueLab.text = CellType.allCases[indexPath.row].value != nil ? CellType.allCases[indexPath.row].value : "▹"
            return cell
        default:
            return UITableViewCell()
        }
     
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "设置"
        case 1:
            return "关于"
        default:
            return ""
        }
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
        case 0:
            return
        case 1:
            let type = dataSouce[indexPath.row]
            if type == .email{
                self.emialMe(email)
            }else if type == .clearCache{
                self.clearCache {
                    tableView.reloadData()
                }
            }else if type == .star{
                self.startApp()
            }
            
        default:
            break
        }
    }
}

extension SettingViewController{
    var isHigh:Bool{
        set{
            UserDefaults.standard.set(newValue, forKey: "MineViewController.isHigh")
        }
        get{
            UserDefaults.standard.bool(forKey: "MineViewController.isHigh")
        }
    }

}

extension UIViewController{
    
    enum CellType:Int,CaseIterable{
        case clearCache
        case star
        case email
        case verstion
        
        var title:String{
            switch self{
            case .clearCache:
                return "清理缓存"
            case .star:
                return "给个好评"
            case .email:
                return "联系我们"
            case .verstion:
                return "版本号"
            }
        }
        
        var value:String?{
            switch self{
            case .clearCache:
                let sizestr = fileSizeWithInterge()
                return sizestr
            case .star:
                return nil
            case .email:
                return nil
            case .verstion:
                return app.version
            }
        }
        public func fileSizeWithInterge() -> String {
    
            let size = Float(SDImageCache.shared.totalDiskSize())
            // 1k = 1024, 1m = 1024k
            if (size < 1024) { //小于1k
                return String(format: "%ldB", size)
            } else if (size < 1024 * 1024) { //小于1M
                return String(format: "%.1fK",(size / 1024))
            } else if (size < 1024 * 1024 * 1024) { //小于1G
                return String(format: "%.1fM",size / (1024 * 1024.0))
            } else { //大于1G
                return String(format: "%.1fM",size / (1024 * 1024 * 1024.0))
            }
        }
    }
    // 清理缓存
    func clearCache(finesh:@escaping(()->())){
        let alert = UIAlertController.init(title: "提示", message: "确定要删除缓存数据", preferredStyle: .alert)
        let commit = UIAlertAction.init(title: "确定", style: .default) {_ in

            SDImageCache.shared.clearDisk()
            UIView.success("清理完成")
            finesh()
        }
        let cancle = UIAlertAction.init(title: "取消", style: .cancel)
        alert.addAction(commit)
        alert.addAction(cancle)
        self.navigationController?.present(alert, animated: true)
    }
    
    // 联系我们
    func emialMe(_ email:String = "we2657932@163.com"){
        let emailUrl = "mailto:\(email)"
        UIApplication.shared.open(URL(string: emailUrl)!, options: [:], completionHandler: nil)
    }
    
    // 给个好评
    func startApp(){
        SKStoreReviewController.requestReview()
    }
}
