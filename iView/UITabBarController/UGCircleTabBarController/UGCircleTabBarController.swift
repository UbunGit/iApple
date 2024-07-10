//
//  UGCircleTabBarController.swift
//  Advertising
//
//  Created by mac on 2022/6/16.
//

import Foundation
import UIKit

open class UGCircleTabBarController:UITabBarController{
    open var custonTabBar:INTabBar = INTabBar()
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(custonTabBar, forKey: "tabBar")
    }

}

// MARK class
extension UGCircleTabBarController{
    
    open class INTabBar:UITabBar{
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            makeUI()
            makeLayout()
            makeConfig()
            backgroundImage = UIImage()
            shadowImage = UIImage()
        }
        
        required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        open lazy var backGroundView: UIView = {
            let value = UIView()
     
            return value
        }()
        func makeUI(){
            addSubview(backGroundView)
        }
        func makeLayout(){
            backGroundView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(8)
                make.right.equalToSuperview().offset(-8)
                make.bottom.equalToSuperview().offset(-(UIScreen.i_safeAreaInsets.bottom/2 + 4))
            }
        }
        func makeConfig(){
            
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = .clear
            appearance.selectionIndicatorTintColor = .clear
            appearance.shadowColor = .clear
            appearance.configureWithTransparentBackground()
            
            standardAppearance = appearance
            
            if #available(iOS 15.0, *) {
                scrollEdgeAppearance = appearance
            }
            
    
        }
    }
}
