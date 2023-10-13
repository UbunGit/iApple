//
//  UGVCAlert.swift
//  UGAlert
//
//  Created by admin on 2022/3/11.
//

import Foundation
import UIKit
public extension UIViewController{
	func presentAlert(_ title:String? = nil,
					  message:String? = nil,
					   cancel:String = "取消",
					  cancelStyle:UIAlertAction.Style = .cancel,
					  cancelHandler:((UIAlertAction) -> Void)? = nil,
					   commit:String? = nil,
					  commitStyle:UIAlertAction.Style = .default,
					  commitHandler:((UIAlertAction) -> Void)? = nil,
					  style:UIAlertController.Style = .alert
	){
		let alertvc = UIAlertController(title: title, message: message, preferredStyle: style)
		let commitac = UIAlertAction.init(title: commit, style: commitStyle, handler: commitHandler)
		let cancelac = UIAlertAction.init(title: cancel, style: cancelStyle, handler: cancelHandler)
		alertvc.addAction(commitac)
		alertvc.addAction(cancelac)
		alertvc.popoverPresentationController?.sourceView = self.view
		alertvc.popoverPresentationController?.sourceRect = self.view.frame
		self.present(alertvc, animated: true, completion: nil)
		
	}
    
	func presentRemark(_ title:String? = nil,
					  message:String? = nil,
					   commit:String? = nil,
					  commitStyle:UIAlertAction.Style = .default,
					  commitHandler:((UIAlertAction) -> Void)? = nil,
					  style:UIAlertController.Style = .alert
	){
		let alertvc = UIAlertController(title: title, message: message, preferredStyle: style)
		let commitac = UIAlertAction.init(title: commit, style: commitStyle, handler: commitHandler)
		alertvc.addAction(commitac)
		alertvc.popoverPresentationController?.sourceView = self.view
		alertvc.popoverPresentationController?.sourceRect = self.view.frame
		self.present(alertvc, animated: true, completion: nil)
		
	}
	
	func i_alert(_ title:String? = nil,
					  message:String? = nil,
					  actions:[UIAlertAction]){
        let alertvc = UIAlertController(title: title, message: message, preferredStyle: .alert)
		actions.forEach { item in
			alertvc.addAction(item)
		}
		alertvc.popoverPresentationController?.sourceView = self.view
		alertvc.popoverPresentationController?.sourceRect = self.view.frame
		self.present(alertvc, animated: true, completion: nil)
	}
    
    func i_sheet(_ title:String? = nil,
               message:String? = nil,
               actions:[UIAlertAction]){
        let alertvc = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { item in
            alertvc.addAction(item)
        }
        alertvc.popoverPresentationController?.sourceView = self.view
        alertvc.popoverPresentationController?.sourceRect = self.view.frame
        let popover = alertvc.popoverPresentationController
        popover?.sourceView = view
        popover?.sourceRect = CGRect(x: 32, y: 32, width: 64, height: 64)

        self.present(alertvc, animated: true)
    }
    
    func i_sheet(view:UIView){
        
    }
}
