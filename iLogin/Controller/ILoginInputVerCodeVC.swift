//
//  SWVerCodeViewController.swift
//  Swimming
//
//  Created by mac on 2022/11/5.
//

import UIKit

open class ILoginInputVerCodeVC: UIViewController {
    
    public lazy var topShapeLayer: CAShapeLayer = {
        let bezierPath = UIBezierPath(ovalIn: CGRect(x:-187 , y: -80, width: 549, height: 351))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.fillColor = view.tintColor.cgColor
        return shapeLayer
    }()
    public lazy var backBtn: UIButton = {
        let value = UIButton()
        value.cfg_back()
        value.setBlockFor(.touchUpInside) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        return value
    }()
    
    lazy var titleLab: UILabel = {
        let value =  UILabel()
        value.numberOfLines = 0
        value.textColor = .white
        let str:NSString = """
输入验证码
已发送验证码至 +86 136****6666
"""
        value.font = .systemFont(ofSize: 16)
        var attributedString = NSMutableAttributedString(string: str as String)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: str.length))
        
        let range = str.range(of: "输入验证码")
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 28), range: range)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: range)
        value.attributedText = attributedString
        return value
    }()
    
    public lazy var verCodeView: MHVerifyCodeView = {
        let value = MHVerifyCodeView()
        value.spacing = 10
        value.verifyCount = 4
        value.setCompleteHandler { (result) in
              print(result)
        }
        return value
    }()
    public lazy var commitBtn: UIButton = {
        let value = UIButton()
        value.cfg_commit()
        value.setTitle("确定", for: .normal)
        return value
    }()
    
   public lazy var repeatBtn: UIButton = {
        let value = UIButton()
        value.titleLabel?.font = .systemFont(ofSize: 14)
        value.setTitleColor(.black.withAlphaComponent(0.65), for: .normal)
        value.setTitle("重新发送?", for: .normal)
        return value
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
    }
    
    open func makeUI(){
        view.backgroundColor = .white
        view.layer.addSublayer(topShapeLayer)
        view.addSubview(backBtn)
        view.addSubview(titleLab)
        view.addSubview(verCodeView)
        view.addSubview(commitBtn)
        view.addSubview(repeatBtn)
    }
    
    open func makeLayout(){
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.size.equalTo(32)
            make.left.equalTo(32)
        }
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(64)
            make.left.equalToSuperview().offset(32)
        }
        verCodeView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.centerY)
            make.size.equalTo(CGSize(width: 300, height: 64))
            make.centerX.equalToSuperview()
        }
        commitBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-64)
            make.size.equalTo(CGSize(width: 280, height: 54))
            make.centerX.equalToSuperview()
        }
        repeatBtn.snp.makeConstraints { make in
            make.top.equalTo(verCodeView.snp.bottom).offset(12)
            make.right.equalTo(commitBtn).offset(-4)
        }
    }
    


}


