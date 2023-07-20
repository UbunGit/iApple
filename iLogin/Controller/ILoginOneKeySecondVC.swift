//
//  UGOneKeySecondVC.swift
//  UGBox
//
//  Created by admin on 2022/11/6.
//

import UIKit

open class ILoginOneKeySecondVC: UIViewController {

    public lazy var backBtn: UIButton = {
        let value = UIButton()
        value.cfg_back()
        value.setBlockFor(.touchUpInside) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        return value
    }()
    
    public lazy var logoImageView: UIImageView  = {
        let value = UIImageView()
        value.image = UIImage(named: "placeholder.logo")
        return value
    }()
    
    public lazy var phoneNOLab: UILabel = {
        let value = UILabel()
        value.text = "132****8888"
        value.textAlignment = .center
        value.textColor = .black.withAlphaComponent(0.75)
        return value
    }()
    
    public lazy var commitBtn: UIButton = {
        let value = UIButton()
        value.cfg_commit()
        value.setTitle("一键免密登录", for: .normal)
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
    }
    
    public func makeUI(){
        view.backgroundColor = .white
        view.addSubview(backBtn)
        view.addSubview(commitBtn)
        view.addSubview(phoneNOLab)
        view.addSubview(logoImageView)
    }
    
    public func makeLayout(){
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(32)
            make.left.equalTo(32)
        }
        
        commitBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 280, height: 54))
        }
        phoneNOLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(commitBtn.snp.top).offset(-32)
            
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(phoneNOLab.snp.top).offset(-32)
            make.size.equalTo(CGSize(width: 128, height: 128))
            
        }
    }
  

}
