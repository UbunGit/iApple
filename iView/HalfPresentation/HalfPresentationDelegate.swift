//
//  HalfPresentationDelegate.swift
//  CocoaLumberjack
//
//  Created by admin on 2023/11/22.
//

import Foundation
open class HalfPresentationDelegate:NSObject,UIViewControllerTransitioningDelegate{
    public static let defual = HalfPresentationDelegate()
    
    var backgroundColor = UIColor.black.withAlphaComponent(0.35)
    var autoDismiss:Bool = true
    var presentationHeight:CGFloat = 500
    
    open func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let halfScreenPresentationController = HalfScreenPresentationController(presentedViewController: presented, presenting: presenting)
        halfScreenPresentationController.presentationHeight = presentationHeight
        halfScreenPresentationController.autoDismiss = autoDismiss
        halfScreenPresentationController.backgroundColor = backgroundColor
        return halfScreenPresentationController
    }
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HalfScreenPresentAnimator()
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HalfScreenDismissAnimator()
    }
}
