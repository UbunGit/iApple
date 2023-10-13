//
//  ViewController.swift
//  EXProgressView
//
//  Created by admin on 2023/10/7.
//

import UIKit
import iApple
class ViewController: IBaseViewController {

    lazy var circleProgressView: CircleProgressView = {
        let value = CircleProgressView()
        return value
    }()
    lazy var lineSlider: UISlider = {
        let value = UISlider()
        value.minimumValue = 1
        value.maximumValue = 30
        value.addTarget(self, action: #selector(lineSliderValueDidChange), for: .valueChanged)
        return value
    }()
    
    lazy var progressSlider: UISlider = {
        let value = UISlider()
        value.minimumValue = 0
        value.maximumValue = 1
        
        value.addTarget(self, action: #selector(progressSliderValueDidChange), for: .valueChanged)
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleProgressView.gradientLayer.colors = [UIColor.clear.cgColor]
        circleProgressView.progress = 0.8
        
    }
    override func makeUI() {
        super.makeUI()
        view.addSubview(circleProgressView)
        view.addSubview(progressSlider)
        view.addSubview(lineSlider)
    }
    override func makeLayout() {
        super.makeLayout()
        circleProgressView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.size.equalTo(CGSize(width: 120, height: 120))
        }
        progressSlider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(circleProgressView.snp.bottom).offset(12)
        }
        lineSlider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(progressSlider.snp.bottom).offset(12)
        }
    }
    
    @objc func lineSliderValueDidChange(){
        circleProgressView.lineWidth = CGFloat(lineSlider.value)
    }
    @objc func progressSliderValueDidChange(){
        circleProgressView.progress = CGFloat(progressSlider.value)
    }
    


}

