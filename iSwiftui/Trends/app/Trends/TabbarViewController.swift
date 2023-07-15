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
class TabbarViewController: UITabBarController {

    lazy var trends: BaseNavViewController = {
        let vc = TrendsItemViewListController()
        return .init(rootViewController: vc)
    }()
    lazy var members: BaseNavViewController = {
        let vc = UIHostingController(rootView: MemberListView())
        return .init(rootViewController: vc)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [trends,members]
    }
    


}
