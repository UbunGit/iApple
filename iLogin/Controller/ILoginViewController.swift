//
//  SWLoginViewController.swift
//  Swimming
//
//  Created by mac on 2022/11/5.
//

import UIKit
import SnapKit
import AVKit
import YYCategories;
import IQKeyboardManagerSwift
open class ILoginViewController: UIViewController {
    
    open lazy var videoUrl:URL? = {
        guard let filePath = Bundle.main.path(forResource: "loginvideo", ofType: "mp4") else{
            return nil
        }
        return URL(fileURLWithPath: filePath)
    }()


    
    public lazy var phoneTextField: ILoginPhoneTextField = {
        let value = ILoginPhoneTextField()
        value.i_radius = 32
        value.leftLab.text = "手机"
        value.placeholder = "请输入手机号码"
        value.backgroundColor = .systemGroupedBackground
        return value
    }()
    
    lazy var titleLab: UILabel = {
        let value =  UILabel()
        value.numberOfLines = 0
        value.font = .systemFont(ofSize: 32, weight: .semibold)
        value.textColor = .white
        value.text = "登录"
        return value
    }()
    
    lazy var nextBtn: UIButton = {
        let value = UIButton()
        value.backgroundColor = view.tintColor
        value.i_radius = 26
        value.setTitle("登录", for: .normal)
        value.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        value.setTitleColor(.white, for: .normal)
        value.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        return value
    }()
    
    lazy var registerBtn: UIButton = {
        let value = UIButton()
        value.setTitle("还没有账号？", for: .normal)
        value.titleLabel?.font = .systemFont(ofSize: 16, weight: .ultraLight)
        value.setTitleColor(view.tintColor, for: .normal)
        value.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        return value
    }()
    
    public lazy var topShapeLayer: CAShapeLayer = {
        let bezierPath = UIBezierPath(ovalIn: CGRect(x:-187 , y: -80, width: 549, height: 351))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.fillColor = view.tintColor.cgColor
        return shapeLayer
    }()
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
        makeLayout()
    
        
    }
 
   
    func makeUI(){
        view.backgroundColor = .white
        view.layer.addSublayer(topShapeLayer)
        view.addSubview(titleLab)
        view.addSubview(phoneTextField)
        view.addSubview(registerBtn)
        view.addSubview(nextBtn)
     
    }
    
    func makeLayout(){
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(64)
            make.left.equalToSuperview().offset(32)
        }
        phoneTextField.snp.remakeConstraints { make in
            make.bottom.equalTo(view.snp.centerY)
            make.size.equalTo(CGSize(width: 300, height: 64))
            make.centerX.equalToSuperview()
        }
        registerBtn.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(12)
            make.right.equalTo(phoneTextField)
        }
        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-64)
            make.size.equalTo(CGSize(width: 280, height: 54))
            make.centerX.equalToSuperview()
        }
       
    }
    
    // 下一步按钮事件
    @objc public  func nextBtnClick(){
        let vc =  ILoginInputVerCodeVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 下一步按钮事件
    @objc public func registerBtnClick(){
        let vc =  ILoginRegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}




