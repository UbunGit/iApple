//
//  CommonRouter.swift
//  iApple
//
//  Created by mac on 2023/3/21.
//

import Foundation
import UIKit
import StoreKit
import MessageUI
extension UIViewController{
    // app 评分
    public func i_start(){
        SKStoreReviewController.requestReview()
    }
    // app twitter
    public func i_twitter(_ name:String){
        let url = "https://twitter.com/\(name)"
        UIApplication.shared.open(.init(string: url)!)
    }
    // mail
    public func i_mail(_ mail:String){
        if MFMailComposeViewController.canSendMail() {
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            
            //设置邮件地址、主题及正文
            mailComposeVC.setToRecipients([mail])
            mailComposeVC.setSubject("APP意见反馈")
            mailComposeVC.setMessageBody("正文:\n\n\n系统版本：\(UIApplication.shared.i_systemVersion)\n设备型号：\(UIApplication.shared.i_modenName) 应用id：\(UIApplication.shared.appBundleID)", isHTML: false)
      
            
            self.present(mailComposeVC, animated: true, completion: nil)
        } else {
            let sendMailErrorAlert = UIAlertController(title: "无法发送邮件", message: "您的设备尚未设置邮箱，请在“邮件”应用中设置后再尝试发送。", preferredStyle: .alert)
            sendMailErrorAlert.addAction(UIAlertAction(title: "确定", style: .default) { _ in })
            
            self.present(sendMailErrorAlert, animated: true)
        }
    }
    
    // share
    public func i_share(title:String? ,activityItems:[Any]){
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityController.modalPresentationStyle = .fullScreen
        activityController.completionWithItemsHandler = {
            (type, flag, array, error) -> Void in
            if flag == true {
                //                    分享成功
            } else {
                //                    分享失败
            }
        }
        self.present(activityController, animated: true, completion: nil)
    }
}

extension UIViewController:MFMailComposeViewControllerDelegate{
    
    public func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismiss(animated: true)
        switch result {
        case .cancelled:
            print("取消发送")
        case .sent:
            print("发送成功")
        
        default:
            break
        }
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
  
    
  
   
}
