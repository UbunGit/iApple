//
//  UGAlert.swift
//  Alamofire
//
//  Created by admin on 2022/2/22.
//

import Foundation
import UIKit
import MBProgressHUD
/**
 提示框调用
 */
public extension UIView {
	
	/**
	 成功提示框,提示在window上
	 e.g
	 UIView.success()
	 */
	static func success(_ msg:String = "success", icon:String = "success.png"){
        UIApplication.shared.i_window?.success(msg)
	}
	
	/**
	 成功提示框，提示在aview上
	 e.g
	 aview.success()
	 */
	func success(_ msg:String = "success", icon:String = "success.png"){
		DispatchQueue.main.async {
			let hud =  self.show(text: msg, icon:icon )
			hud.tag = 6000
			DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
				self .hubhidden(6000)
			}
			
		}
	}
	
	/**
	 错误提示框,提示在window上
	 e.g
	 UIView.error()
	 */
	static func error(_ msg:String = "error", icon:String = "error.png"){
		DispatchQueue.main.async {
			 UIApplication.shared.i_window?.error(msg)
		}
	}
	static func error(_ msg:String = "error"){
		DispatchQueue.main.async {
			 UIApplication.shared.i_window?.error(msg)
		}
	}
	
	/**
	 错误提示框,提示在aview上
	 e.g
	 aview.error()
	 */
	func error(_ msg:String = "error" , icon:String = "error.png"){
	
		DispatchQueue.main.async {
			let hud =  self.show(text: msg as String, icon: icon )
			hud.tag = 6001
			hud.contentColor = UIColor(hexString: "#EEEEEE")
			hud.bezelView.style = .solidColor
            hud.bezelView.tintColor = .white
			hud.bezelView.backgroundColor = UIColor(hexString: "#131313")
			DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
				self .hubhidden(6001)
			}
		}
	}
	/**
	 错误提示框,提示在aview上
	 e.g
	 aview.error()
	 */
	func error(_ msg:String = "error"){
		DispatchQueue.main.async {
			self.error(msg, icon: "error.png")
		}
	}

  
	
	/**
	 debug 错误提示框,提示在window上
	 e.g
	 UIView.error()
	 */
	static func debug(_ msg:String = "error", icon:String = "error.png"){
		DispatchQueue.main.async {
			 UIApplication.shared.i_window?.debug(msg)
		}
	}
	
	/**
	 debug 错误提示框,提示在aview上
	 e.g
	 aview.error()
	 */
	func debug(_ mag:String = "error" , icon:String = "error.png"){
		#if DEBUG
		DispatchQueue.main.async {
			let hud =  self.show(text: mag as String, icon: icon )
			hud.bezelView.backgroundColor = .red
			hud.tag = 6002
			DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
				self .hubhidden(6002)
			}
		}
		#endif
		
	}
	
	static func progressLoading(_ msg: String? = nil) {
		 UIApplication.shared.i_window?.progressLoading(msg)
	}
	
	func progressLoading(_ msg: String? = nil) {
		DispatchQueue.main.async {
			let hud = self.show(text: msg, icon: nil)
			hud.mode = .annularDeterminate
			hud.tag = 6005
		}
	}
	

	
	static func showProgress(progress: CGFloat) {
		DispatchQueue.main.async {
			 UIApplication.shared.i_window?.showProgress(progress: progress)
		}
	}
	
    static func progressDismiss() {
        DispatchQueue.main.async {
             UIApplication.shared.i_window?.progressDismiss()
        }
    }
	func showProgress(progress: CGFloat) {
		guard let bgview = self.viewWithTag(6005) as? MBProgressHUD else {
			return
		}
		bgview.progress = Float(progress)
	}
	
	func progressDismiss() {
		self.hubhidden(6005)
		
	}
	
	/**
	 加载框，提示在window上
	 e.g
	 UIView.lodding()
	 */
	static func loading(_ msg:String? = nil, isIcon:Bool = true) {
		 UIApplication.shared.i_window?.loading(msg, isIcon: isIcon);
	}
	
	/**
	 加载框，提示在aview上
	 e.g
	 aview.lodding()
	 */
	func loading(_ msg:String? = nil, isIcon:Bool = true){
		DispatchQueue.main.async {
            var hud:MBProgressHUD? = nil
            if let view = self.viewWithTag(6003) as? MBProgressHUD{
                hud = view
            }else{
                hud = self.show(text: msg, icon: nil)
            }
            guard let hud = hud else {
                return
            }
			hud.tag = 6003
			var images:[UIImage] = []
		
			if isIcon && images.count>0 {
              

				let imageView = UIImageView.init(frame: .init(x: 0, y: 0, width: 64, height: 64))
			
				imageView.animationDuration = 0.8
				imageView.animationImages = images
				// 开始播放
				imageView.startAnimating()
				hud.customView = imageView
				hud.margin = 5
				hud.bezelView.style = .solidColor
				hud.bezelView.backgroundColor = .clear
				hud.mode = .customView
			}else {
            
                hud.bezelView.style = .solidColor
//                hud.bezelView.backgroundColor = .black.withAlphaComponent(0.35)
				hud.mode = .indeterminate
                hud.bezelView.color = UIColor(hexString: "#333333")
                hud.bezelView.style = .solidColor;
                
			}
		}
	}
	
	/**
	 清除加载框
	 e.g
	 UIView.loadingDismiss()
	 */
	static func loadingDismiss(){
		DispatchQueue.main.async {
			 UIApplication.shared.i_window?.loadingDismiss()
		}
	}
	
	/**
	 清除加载框
	 e.g
	 aview.loadingDismiss()
	 */
	func loadingDismiss(){
        DispatchQueue.main.async {
            guard let hub = self.viewWithTag(6003) as? MBProgressHUD  else {
                return
            }
            hub.subviews.forEach { aview in
                if  let imgview = aview as? UIImageView{
                    imgview.stopAnimating()
                    imgview.removeFromSuperview()
                }
            }
            self.hubhidden(6003)
        }
	}
	
	func alertView(aview:UIView) {
		let bgview = UIView(frame: self.bounds)
		bgview.tag = 6004
		DispatchQueue.main.async {
			
			bgview.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
			bgview.alpha = 0
			self.addSubview(bgview)
			bgview.addSubview(aview)
			aview.center = self.center
			UIView.animate(withDuration: 0.35) {
				bgview.alpha = 1
			}
		}
	   
		
	}
	
	func hiddenAlertView() {
		
		guard let bgview = self.viewWithTag(6004)  else {
			return
		}
		DispatchQueue.main.async{
			bgview.removeFromSuperview()
			self.isUserInteractionEnabled = true;
		}
	}
}

private extension UIView{
	
	func show(text:String?, icon:String?) -> MBProgressHUD {

		let hud = MBProgressHUD.showAdded(to: self, animated: true)
		if text != nil {
			
			hud.label.text = text;
			hud.label.textColor = .white
			hud.label.numberOfLines = 0
			hud.label.font = .systemFont(ofSize: 17)
		}
		if icon != nil {
			hud.customView = UIImageView.init(image: UIImage.init(named: icon ?? ""))
		}
		hud.bezelView.backgroundColor = .black    //背景颜色
		hud.mode = .customView;
		hud.removeFromSuperViewOnHide = true;
		return hud
	}
	
	func hubhidden(_ viewTag:Int)  {
		self.isUserInteractionEnabled = true;
		guard let hub = self.viewWithTag(viewTag) as? MBProgressHUD  else {
			return
		}
		hub.hide(animated: false)
	}
}
