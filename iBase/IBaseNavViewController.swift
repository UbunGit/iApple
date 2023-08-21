//
//  IBaseNavViewController.swift
//  iApple
//
//  Created by admin on 2023/8/15.
//

import UIKit

open class IBaseNavViewController: UINavigationController {

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count>=1{
            viewController.hidesBottomBarWhenPushed = true
            navigationBar.prefersLargeTitles = false
        }
        super.pushViewController(viewController, animated: animated)
    }

}
