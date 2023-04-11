//
//  UIView.swift
//  Sample
//
//  Created by admin on 2022/11/6.
//

import Foundation
import UIKit
import SnapKit
public enum TostLevel:Int{
    
    case debug
    case warning
    case error
    case succeed
    
    var backgroundColor:UIColor{
        switch self{
        case .debug:
            return .blue
        case .warning:
            return .orange
        case .error:
            return .red
        case .succeed:
            return .green
        }
    }
}

let tostHub = HUbView()

public extension UIView{
    static func tost(title:String? = nil ,msg:String,level:TostLevel = .error){
        DispatchQueue.main.async {
            UIApplication.shared.i_window?.tost(title:title ,msg:msg,level:level)
        }
        
    }
    func tost(title:String? = nil ,msg:String,level:TostLevel = .error){
        DispatchQueue.main.async {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.tostDisappear), object: nil)
            if let title = title{
                tostHub.titleLab.isHidden = false
                tostHub.titleLab.text = title
            }else{
                tostHub.titleLab.isHidden = true
            }
            tostHub.backgroundColor = level.backgroundColor
            tostHub.msgLab.text = msg
            self.addSubview(tostHub)
            tostHub.snp.remakeConstraints { make in
                make.top.equalToSuperview()
                make.left.right.equalToSuperview()
                make.height.equalTo(1)
            }
            self.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.35) {
                tostHub.snp.remakeConstraints { make in
                    make.top.equalToSuperview()
                    make.left.right.equalToSuperview()
                }
                self.layoutIfNeeded()
            }
            self.perform(#selector(self.tostDisappear), afterDelay: 3)
        }
    }
    
    @objc func tostDisappear(){
        
        tostHub.removeFromSuperview()
        
    }
}

class HUbView:UIView{
    
    lazy var stackView : UIStackView = {
        let value = UIStackView()
        value.axis = .vertical
        return value
    }()
    
    lazy var titleLab: UILabel = {
        let value = UILabel()
        value.font = .boldSystemFont(ofSize: 18)
        value.textColor = .white
        return value
    }()
    
    lazy var msgLab: UILabel = {
        let value = UILabel()
        value.numberOfLines = 0
        value.font = .systemFont(ofSize: 14)
        value.textColor = .white
        return value
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makUI()
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makUI(){
        addSubview(stackView)
        stackView.addSubview(titleLab)
        stackView.addSubview(msgLab)
    }
    func makeLayout(){
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(self.snp_topMargin)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalTo(msgLab.snp.top).offset(-8)
        }
        msgLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}
