//
//  UIImage.swift
//  Alamofire
//
//  Created by mac on 2023/4/10.
//

import Foundation
import UIKit
public extension UIPageViewController {

    var scrollView: UIScrollView? {

        return view.subviews.filter { $0 is UIScrollView }.first as? UIScrollView
    }
}
