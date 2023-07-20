//
//  BubbleTabBarController.swift
//  BubbleTabBar
//
//  Created by Anton Skopin on 28/11/2018.
//  Copyright © 2018 cuberto. All rights reserved.
//

import UIKit

open class BubbleTabBarController: UITabBarController {

    fileprivate var shouldSelectOnTabBar = true

    open override var selectedViewController: UIViewController? {
        willSet {
            guard shouldSelectOnTabBar,
                  let newValue = newValue else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? BubbleTabBar,
                  let index = viewControllers?.firstIndex(of: newValue) else {
                return
            }
            tabBar.select(itemAt: index, animated: false)
        }
    }

    open override var selectedIndex: Int {
        willSet {
            guard shouldSelectOnTabBar else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? BubbleTabBar else {
                return
            }
            tabBar.select(itemAt: selectedIndex, animated: false)
        }
    }
    lazy var tabBarView: BubbleTabBar = {
        let value = BubbleTabBar()
      
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(tabBarView, forKey: "tabBar")
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private var _barHeight: CGFloat = 74
    open var barHeight: CGFloat {
        get {
            _barHeight + view.safeAreaInsets.bottom
        }
        set {
            _barHeight = newValue
            updateTabBarFrame()
        }
    }

    private func updateTabBarFrame() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = self.view.frame.size.height - barHeight
        self.tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarFrame()
    }

    open override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        updateTabBarFrame()
    }

    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.firstIndex(of: item) else {
            return
        }
        if let controller = viewControllers?[idx] {
            shouldSelectOnTabBar = false
            selectedIndex = idx
            delegate?.tabBarController?(self, didSelect: controller)
        }
    }

}
