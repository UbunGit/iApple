//
//  SettingViewController.swift
//  MediaBox
//
//  Created by mac on 2022/11/28.
//

import UIKit
import SDWebImage
import StoreKit

public enum SettingLanguage{
    case zh
    case en
}
enum SettingWord{
    case Setting
    case UserAgreement
    case PrivateAgreement
    case Feedback
    case Version
    case Review
    case ContactUs
    case ShareApp
    
    func str(language:SettingLanguage) -> String{
        switch self{
        case .Setting:
            return (language == .zh) ? "设置" : "Setting"
        case .UserAgreement:
            return (language == .zh) ? "用户协议" : "User Agreement"
        case .PrivateAgreement:
            return (language == .zh) ? "隐私协议" : "Private Agreement"
        case .Feedback:
            return (language == .zh) ? "意见反馈" : "Feedback"
        case .Version:
            return (language == .zh) ? "版本号" : "Version Number"
        case .Review:
            return (language == .zh) ? "给个好评" : "Review"
        case .ContactUs:
            return (language == .zh) ? "联系我" : "Contact us"
        case .ShareApp:
            return (language == .zh) ? "分享app" : "Share app"
        }
    }
    
}

open class ISettingViewController: UIViewController {
    public var language:SettingLanguage = .en
    public var email:String = "we2657932@163.com"
    public var userurl:String = "https://homewh.chaoxing.com/agree/userAgreement"
    public var privateurl:String = "https://www.julyedu.com/agreement/priv"
    public var dataSouce:[GroupData] = []
    public var appid:String = "8888888888"
    
    public lazy var tableView: UITableView = {
        let value = UITableView(frame: .zero, style: .insetGrouped)
        value.delegate = self
        value.dataSource = self
        value.i_registerCell(UITableViewCell.self)
        value.i_registerCell(SettingSwitchCell.self)
        value.i_registerCell(SettingRightArrowCell.self)
        
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        title = "关于"
        reloadData()
        makeUI()
        makeLayout()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    open func makeUI(){
        view.addSubview(tableView)
    }
    
    open func makeLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    public  lazy var data_feedback: GroupData.ItemData = {
        .init(title: SettingWord.Feedback.str(language: language),cellType: SettingRightArrowCell.self, handle:  {
            self.handle_feedback()
        })
    }()
    public lazy var data_user_agreement: GroupData.ItemData = {
        .init(title: SettingWord.UserAgreement.str(language: language),cellType: SettingRightArrowCell.self, handle:  {
            self.handle_user_agreement()
        })
    }()
    public lazy var data_private_agreement: GroupData.ItemData = {
        .init(title: SettingWord.PrivateAgreement.str(language: language),cellType: SettingRightArrowCell.self, handle:  {
            self.handle_private_agreement()
        })
    }()
    public lazy var data_bannedUser: GroupData.ItemData = {
        .init(title: "注销账号",cellType: SettingRightArrowCell.self, handle:  {
            self.handle_bannedUser()
        })
    }()
    
    public lazy var data_shareApp: GroupData.ItemData = {
        .init(title: SettingWord.ShareApp.str(language: language),cellType: SettingRightArrowCell.self, handle:  {
            self.shareApp(appid: self.appid)
        })
    }()

   public lazy var data_clearCache: GroupData.ItemData = {
        return .init(title:"清理缓存",cellType: SettingRightArrowCell.self) {
            self.fileSizeWithInterge()
        } handle: {
            self.clearCache {
                self.view.tost(msg: "清理完成")
                self.tableView.reloadData()
            }
        }
    }()
    open func reloadData(){
        dataSouce.append(
            .init(title: SettingWord.Setting.str(language: language), items: [
//                data_clearCache,
                data_shareApp,
                .init(title: SettingWord.Review.str(language: language),cellType: SettingRightArrowCell.self, handle: {
                    self.startApp()
                }),
                .init(title: SettingWord.ContactUs.str(language: language),cellType: SettingRightArrowCell.self, handle: {
                    self.emialMe(self.email)
                }),
                .init(title: SettingWord.Version.str(language: language),
                      cellType: SettingRightArrowCell.self,
                      value: {
                          UIApplication.shared.appVersion
                      }),
//                data_bannedUser
                
            ])
            
            
        )
        dataSouce.append(
            .init(title: "协议", items: [
                
                data_user_agreement,
                data_private_agreement,
                data_feedback,
            ])
        )
    }
    
    open func handle_feedback(){
        let vc = ISettingFeedbackVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    open func handle_user_agreement(){
        let url = "https://homewh.chaoxing.com/agree/userAgreement"
        UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
    }
    open func handle_private_agreement(){
        let url = "https://www.julyedu.com/agreement/priv"
        UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
    }
    // 注销用户
    open func handle_bannedUser(){
        let vc = ISettingBannedUserVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ISettingViewController:I_UITableViewProtocol{
    open func numberOfSections(in tableView: UITableView) -> Int {
        return dataSouce.count
    }
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sessionData = dataSouce[section]
        return sessionData.items.count
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sessionData = dataSouce[indexPath.section]
        let rownData = sessionData.items[indexPath.row]
        
        let cell = tableView.i_dequeueReusableCell(SettingRightArrowCell.self, for: indexPath)
        cell.textLabel?.text = rownData.title
        cell.valueLab.text = rownData.value?()
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sessionData = dataSouce[section]
        return sessionData.title
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sessionData = dataSouce[indexPath.section]
        let rownData = sessionData.items[indexPath.row]
        rownData.handle?()
    }
}

extension UIViewController{
    
    
    // 获取缓存大小
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
    // 清理缓存
    public func clearCache(finesh:@escaping(()->())){
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
    public func emialMe(_ email:String = "we2657932@163.com"){
        let emailUrl = "mailto:\(email)"
        UIApplication.shared.open(URL(string: emailUrl)!, options: [:], completionHandler: nil)
    }
    
    // 给个好评
    public func startApp(){
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if #available(iOS 14.0, *) {
                SKStoreReviewController.requestReview(in: windowScene)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    // 分享app
    public func shareApp(appid:String){
        // 用于分享的App链接
        guard let appURL = URL(string: "https://apps.apple.com/us/app/id\(appid)")else{
            return
        }
        let activityViewController = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop]
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}
