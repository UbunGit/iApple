//
//  IVipBandlet.swift
//  iPods
//
//  Created by admin on 2024/1/3.
//

import UIKit

open class IVIPBandleView:IBaseView{
    
    lazy var bgImageView: UIImageView = {
        let value = UIImageView()
        value.image = .i_image(name: "vip.bg")
        return value
    }()
    
    lazy var vip_icon: UIImageView = {
        let value = UIImageView()
        value.image = .i_image(name: "vip.icon")
        return value
    }()
    
    lazy var desLab: UILabel = {
        let valueLab = UILabel()
        valueLab.text = "开通VIP享更多权益"
        valueLab.font = .systemFont(ofSize: 11, weight: .medium)
        valueLab.textColor = .init(hexString: "#FFF1D1")
        return valueLab
    }()
    
    lazy var commitBtn: UIButton = {
        let value = UIButton()
        value.i_radius = 12
        let gradientLayer = GradientView.init()
        gradientLayer.colors = [.init(hexString: "#FFE3A2")!,.init(hexString: "#FFF1D1")!]
      
        value.addSubview(gradientLayer)
        gradientLayer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        value.setTitle("立即开通", for: .normal)
        value.setTitleColor(.init(hexString: "7C4601"), for: .normal)
        value.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        
        return value
    }()
    
    open override func makeUI() {
        super.makeUI()
        addSubview(bgImageView)
        addSubview(vip_icon)
        addSubview(desLab)
        addSubview(commitBtn)
    }
    open override func makeLayout() {
        super.makeLayout()
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        vip_icon.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.centerY)
            make.leading.equalToSuperview().offset(65)
        }
        desLab.snp.makeConstraints { make in
            make.leading.equalTo(vip_icon)
            make.top.equalTo(vip_icon.snp.bottom).offset(8)
        }
        commitBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 72, height: 28))
        }
    }
    
    
}

