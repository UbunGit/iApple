//
//  TabbarViewController.swift
//  Trends
//
//  Created by mac on 2023/7/15.
//

import UIKit
import SwiftUI
class BaseNavViewController:UINavigationController{
    
}
class TabbarViewController: BubbleTabBarController {

    lazy var trends: BaseNavViewController = {
        let vc = TrendsItemViewListController()
       
        vc.tabBarItem = .init(title: "首页",
                              image: .init(systemName: "house"),
                              selectedImage: .init(systemName: "house.fill")?.withTintColor(.red))
        return .init(rootViewController: vc)
    }()
    lazy var members: BaseNavViewController = {
        let vc = UIHostingController(rootView: MemberListView())
        vc.tabBarItem = .init(title: "搜索",
                              image: .init(systemName: "magnifyingglass.circle"),
                              selectedImage: .init(systemName: "magnifyingglass.circle.fill")?.withTintColor(.yellow)
        )
        return .init(rootViewController: vc)
    }()
    
    lazy var members1: BaseNavViewController = {
        let vc = UIHostingController(rootView: MemberListView())
    
        vc.tabBarItem = .init(title: "关注",
                              image: .init(systemName: "heart"),
                              selectedImage: .init(systemName: "heart.fill")?.withTintColor(.blue))
        return .init(rootViewController: vc)
    }()
    lazy var members2: BaseNavViewController = {
        let vc = UIHostingController(rootView: MemberListView())
        
        vc.tabBarItem = .init(title: "设置",
                              image: .init(systemName: "gear"),
                              selectedImage: .init(systemName: "gear.circle.fill")?.withTintColor(.orange))
        return .init(rootViewController: vc)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [trends,members,members1,members2]
        self.tabBarView.centerBtn.setBlockFor(.touchUpInside) { _ in
            let vc = TrendsPublishViewController()
            let nav = BaseNavViewController(rootViewController: vc)
            self.present(nav, animated: true)
        }
    }

}
