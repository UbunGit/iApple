//
//  ILoginWelcomeViewController.swift
//  iApple
//
//  Created by mac on 2023/7/19.
//

import Foundation
open class ILoginWelcomeViewController:UIViewController{
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
    }
    public lazy var titleLab: UILabel = {
        let value = UILabel()
        value.text = "欢迎使用我的APP"
        value.font = .systemFont(ofSize: 32, weight: .semibold)
        return value
    }()
    
    public lazy var desLab: UILabel = {
        let value = UILabel()
        value.text = "分享自己的优秀设计,从别人的设计中寻找灵感"
        value.font = .systemFont(ofSize: 16, weight: .ultraLight)
        return value
    }()
    public lazy var nextBtn: UIButton = {
        let value = UIButton()
        value.backgroundColor = .white
        value.i_radius = 26
        value.setTitle("开始吧！", for: .normal)
        value.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        value.setTitleColor(view.tintColor, for: .normal)
        value.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        return value
    }()
    public  func makeUI(){
        view.layer.addSublayer(topShapeLayer)
        view.layer.addSublayer(bottpmShapeLayer)
        view.addSubview(nextBtn)
        view.addSubview(titleLab)
        view.addSubview(desLab)
    }
    public  func makeLayout(){
        titleLab.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-32)
            make.left.equalToSuperview().offset(32)
        }
        desLab.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(12)
            make.left.equalTo(titleLab)
        }
        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-64)
            make.size.equalTo(CGSize(width: 280, height: 54))
            make.centerX.equalToSuperview()
        }
    }
    public lazy var topShapeLayer: CAShapeLayer = {
        let bezierPath = UIBezierPath(ovalIn: CGRect(x:200 , y: -114, width: 267, height: 375))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.fillColor = view.tintColor.cgColor
        return shapeLayer
    }()
    
    public lazy var bottpmShapeLayer: CAShapeLayer = {
        let bezierPath = UIBezierPath(ovalIn: CGRect(x:-187 , y: UIScreen.main.bounds.size.height-300, width: 549, height: 351))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.fillColor = view.tintColor.cgColor
        return shapeLayer
    }()
    
    // 下一步按钮事件
    @objc public  func nextBtnClick(){
        let vc =  ILoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
