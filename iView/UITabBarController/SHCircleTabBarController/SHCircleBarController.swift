//
//  SHCircleBarController.swift
//  SHCircleBar
//
//  Created by Adrian Perțe on 19/02/2019.
//  Copyright © 2019 softhaus. All rights reserved.
//

import UIKit

open class SHCircleBarController: UITabBarController {

    open var custonTabBar:SHCircleBar = SHCircleBar()
    open var circleView : UIView!
    open var circleImageView: UIImageView!
    private var deviceOrient:UIDeviceOrientation? = nil
   
    public override var selectedViewController: UIViewController? {
        willSet {
            guard let newValue = newValue,
                  let tabBar = tabBar as? SHCircleBar,
                  let index = viewControllers?.firstIndex(of: newValue)
                  else { return }
            updateCircle(index: index)
            tabBar.select(itemAt: index, animated: true)
        }
    }
    
    public override var selectedIndex: Int {
        willSet {
            guard let tabBar = tabBar as? SHCircleBar else { return }
            updateCircle(index: newValue)
            tabBar.select(itemAt: newValue, animated: true)
        }
    }
    
    private var _barHeight: CGFloat = 49
    public var barHeight: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return _barHeight + view.safeAreaInsets.bottom
            } else { return _barHeight }
        }
        set {
            _barHeight = newValue
            updateTabBarFrame()
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChangeNotification), name: UIDevice.orientationDidChangeNotification, object: nil)
        self.setValue(custonTabBar, forKey: "tabBar")
        addCirleView()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.35) {
            if  self.tabBar.selectedItem == nil{
                self.selectedViewController = self.viewControllers?.first
            }
        }
       
 
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarFrame()
    }
    deinit{
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    @objc func orientationDidChangeNotification(){
        let orient = UIDevice.current.orientation
        if orient == deviceOrient{
            return
        }
        deviceOrient = orient
        guard let newValue = selectedViewController,
              let index = viewControllers?.firstIndex(of: newValue)
        else { return }
        updateTabBarFrame()
        updateCircle(index: index)
    }
    
    open override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        }
        updateTabBarFrame()
    }
    
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        updateCircle(index: index)
    }
    
}

extension SHCircleBarController {
    public func updateCircle(index: Int) {
        let items = tabBar.items ?? []
        let vcs = viewControllers ?? []
        guard index < items.count,
              index < vcs.count
                /*index != selectedIndex*/ else { return }
        
        let item = items[index]
        let controller = vcs[index]
            
        let tabWidth = self.view.bounds.width / CGFloat(items.count)
        let circleWidth = self.circleView.bounds.width
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let `self` = self else { return }
            self.circleView.frame = CGRect(
                x: (tabWidth * CGFloat(index) + tabWidth / 2 - circleWidth*0.5),
                y: self.circleView.frame.minY,
                width: circleWidth,
                height: circleWidth)
        }
        
        UIView.animate(withDuration: 0.15) { [weak self] in
            self?.circleImageView.alpha = 0
        } completion: { [weak self] (_) in
            self?.circleImageView.image = item.selectedImage
            UIView.animate(withDuration: 0.15, animations: { [weak self] in
                self?.circleImageView.alpha = 1
            })
           
        }
    
      
        delegate?.tabBarController?(self, didSelect: controller)
    }
    
    fileprivate func updateTabBarFrame() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = self.view.frame.size.height - barHeight
        self.tabBar.frame = tabFrame
        tabBar.layoutIfNeeded()
    }
    
    fileprivate func addCirleView() {
        
        let circleViewWidth:CGFloat = 64
        let circleViewRadius:CGFloat = 32
        
        self.circleView = UIView(frame: .zero)
        circleView.layer.cornerRadius = circleViewRadius
        circleView.backgroundColor = .systemBackground
        
        self.circleImageView = UIImageView(frame: .zero)
        circleImageView.layer.cornerRadius = circleViewRadius
        circleImageView.isUserInteractionEnabled = false
        circleImageView.contentMode = .scaleAspectFill
        
        circleView.addSubview(circleImageView)
        self.custonTabBar.insertSubview(circleView, at: 9999)
        
        circleView.layer.shadowOffset = CGSize(width: 0, height: 0)
        circleView.layer.shadowRadius = 2
        circleView.layer.shadowColor = UIColor.white.cgColor
        circleView.layer.shadowOpacity = 0.15
        
      
        circleView.frame = CGRect(
            x: circleViewWidth/2,
            y: -circleViewWidth/2,
            width: circleViewWidth,
            height: circleViewWidth)
        circleImageView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
       
    }
    
 
}
