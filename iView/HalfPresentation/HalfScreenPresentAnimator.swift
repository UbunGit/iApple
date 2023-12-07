//
//  HalfScreenPresentAnimator.swift
//  CocoaLumberjack
//
//  Created by admin on 2023/11/22.
//

import Foundation
open class HalfScreenPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        
        // 设置半屏 View Controller 的初始位置
        toView.frame = CGRect(x: 0, y: containerView.frame.height, width: containerView.frame.width, height: containerView.frame.height/2)
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            // 设置半屏 View Controller 的最终位置
            toView.frame = CGRect(x: 0, y: containerView.frame.height/2, width: containerView.frame.width, height: containerView.frame.height/2)
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
}
