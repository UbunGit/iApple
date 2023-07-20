//
//  BubbleTabBar.swift
//  BubbleTabBar
//
//  Created by Anton Skopin on 28/11/2018.
//  Copyright © 2018 cuberto. All rights reserved.
//

import UIKit

open class BubbleTabBar: UITabBar {
    lazy var centerBtn: UIButton = {
        let value = UIButton()
        value.layer.cornerRadius = 22
//        tintColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.431372549, alpha: 1)
        value.backgroundColor =  #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.431372549, alpha: 1).withAlphaComponent(0.15)
        value.setImage(.init(systemName: "plus.square.on.square")?, for: .normal)
        value.tintColor = .red.withAlphaComponent(0.35)
        return value
    }()
   
    private var buttons: [CBTabBarButton] = []
    public var animationDuration: Double = 0.3
    
    open override var selectedItem: UITabBarItem? {
        willSet {
            guard let newValue = newValue else {
                buttons.forEach { $0.setSelected(false) }
                return
            }
            guard let index = items?.firstIndex(of: newValue),
                index != NSNotFound else {
                    return
            }
            select(itemAt: index, animated: false)
        }
    }
        
    open override var tintColor: UIColor! {
        didSet {
            buttons.forEach { button in
                if (button.item as? CBTabBarItem)?.tintColor == nil {
                    button.tintColor = tintColor
                }
            }
        }
    }
    
    override open var backgroundColor: UIColor? {
        didSet {
            barTintColor = backgroundColor
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var leftContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    lazy var rightContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private var csContainerBottom: NSLayoutConstraint!
    
    private func configure() {
        backgroundColor = UIColor.white
        isTranslucent = false
        barTintColor = UIColor.white
        tintColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.431372549, alpha: 1)
        addSubview(container)
        
        container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        container.topAnchor.constraint(equalTo: topAnchor, constant: 1).isActive = true
        
        container.addSubview(leftContainer)
        container.addSubview(rightContainer)
        container.addSubview(centerBtn)
        
        centerBtn.snp.makeConstraints { make in
            make.size.equalTo(44)
            make.center.equalToSuperview()
        }
        leftContainer.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(centerBtn.snp.left).offset(-10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        rightContainer.snp.makeConstraints { make in
            make.left.equalTo(centerBtn.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let bottomOffset: CGFloat
        if #available(iOS 11.0, *) {
            bottomOffset = safeAreaInsets.bottom
        } else {
            bottomOffset = 0
        }
        csContainerBottom = container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomOffset)
        csContainerBottom.isActive = true
    }
    
    override open func safeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.safeAreaInsetsDidChange()
            csContainerBottom.constant = -safeAreaInsets.bottom
        } else { }
    }
    
    open override var items: [UITabBarItem]? {
        didSet {
            reloadViews()
        }
    }
    
    open override func setItems(_ items: [UITabBarItem]?, animated: Bool) {
        super.setItems(items, animated: animated)
        reloadViews()
    }
    
    private var lspaceLayoutGuides:[UILayoutGuide] = []
    private var rspaceLayoutGuides:[UILayoutGuide] = []
    private func reloadViews() {
        
 
        
        subviews.filter { String(describing: type(of: $0)) == "UITabBarButton" }.forEach { $0.removeFromSuperview() }
        buttons.forEach { $0.removeFromSuperview() }
      
        buttons = items?.map { self.button(forItem: $0) } ?? []
        buttons.enumerated().forEach { (index,button) in
            if index<buttons.count/2{
                leftContainer.addSubview(button)
                button.topAnchor.constraint(equalTo: self.leftContainer.topAnchor).isActive = true
                button.bottomAnchor.constraint(equalTo: self.leftContainer.bottomAnchor).isActive = true
            }else{
                rightContainer.addSubview(button)
                button.topAnchor.constraint(equalTo: self.rightContainer.topAnchor).isActive = true
                button.bottomAnchor.constraint(equalTo: self.rightContainer.bottomAnchor).isActive = true
            }

        }
   
        lspaceLayoutGuides = [];
        lspaceLayoutGuides.forEach { self.container.removeLayoutGuide($0) }
        let leftBtns = leftContainer.subviews
        leftBtns.first?.leadingAnchor.constraint(equalTo: leftContainer.leadingAnchor, constant:0).isActive = true
        leftBtns.last?.trailingAnchor.constraint(equalTo: leftContainer.trailingAnchor, constant: 0).isActive = true
        let leftviewCount = leftBtns.count - 1
        for i in 0..<leftviewCount {
            let layoutGuide = UILayoutGuide()
            container.addLayoutGuide(layoutGuide)
            lspaceLayoutGuides.append(layoutGuide)
            let prevBtn = leftBtns[i]
            let nextBtn = leftBtns[i + 1]
           
            layoutGuide.leadingAnchor.constraint(equalTo: prevBtn.trailingAnchor).isActive = true
            layoutGuide.trailingAnchor.constraint(equalTo: nextBtn.leadingAnchor).isActive = true
        }
        for layoutGuide in lspaceLayoutGuides[1...] {
            layoutGuide.widthAnchor.constraint(equalTo: lspaceLayoutGuides[0].widthAnchor, multiplier: 1.0).isActive = true;
        }
        
        rspaceLayoutGuides = [];
        rspaceLayoutGuides.forEach { self.container.removeLayoutGuide($0) }
        let rightBtns = rightContainer.subviews
        rightBtns.first?.leadingAnchor.constraint(equalTo: rightContainer.leadingAnchor, constant:0).isActive = true
        rightBtns.last?.trailingAnchor.constraint(equalTo: rightContainer.trailingAnchor, constant:0).isActive = true
        let rightBtnsviewCount = rightBtns.count - 1
        for i in 0..<rightBtnsviewCount {
            let layoutGuide = UILayoutGuide()
            container.addLayoutGuide(layoutGuide)
            rspaceLayoutGuides.append(layoutGuide)
            let prevBtn = rightBtns[i]
            let nextBtn = rightBtns[i + 1]
           
            layoutGuide.leadingAnchor.constraint(equalTo: prevBtn.trailingAnchor).isActive = true
            layoutGuide.trailingAnchor.constraint(equalTo: nextBtn.leadingAnchor).isActive = true
        }
        
        
        
        for layoutGuide in rspaceLayoutGuides[1...] {
            layoutGuide.widthAnchor.constraint(equalTo: rspaceLayoutGuides[0].widthAnchor, multiplier: 1.0).isActive = true;
        }
        layoutIfNeeded()
    }
    
    private func button(forItem item: UITabBarItem) -> CBTabBarButton {
        let button = CBTabBarButton(item: item)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(.required, for: .horizontal)
        if (button.item as? CBTabBarItem)?.tintColor == nil {
            button.tintColor = tintColor
        }
        button.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        if selectedItem != nil && item === selectedItem {
            button.setSelected(true)
        }
        return button
    }
    
    @objc private func btnPressed(sender: CBTabBarButton) {
        guard let index = buttons.firstIndex(of: sender),
            index != NSNotFound,
            let item = items?[index] else {
                return
        }
        buttons.forEach { (button) in
            guard button != sender else {
                return
            }
            button.setSelected(false, animationDuration: animationDuration)
        }
        sender.setSelected(true, animationDuration: animationDuration)
        UIView.animate(withDuration: animationDuration) {
            self.container.layoutIfNeeded()
        }
        delegate?.tabBar?(self, didSelect: item)
    }
    
    func select(itemAt index: Int, animated: Bool = false) {
        guard index < buttons.count else {
            return
        }
        let selectedbutton = buttons[index]
        buttons.forEach { (button) in
            guard button != selectedbutton else {
                return
            }
            button.setSelected(false, animationDuration: animated ? animationDuration : 0)
        }
        selectedbutton.setSelected(true, animationDuration: animated ? animationDuration : 0)
        if animated {
            UIView.animate(withDuration: animationDuration) {
                self.container.layoutIfNeeded()
            }
        } else {
            self.container.layoutIfNeeded()
        }
    }
    
}
