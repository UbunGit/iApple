//
//  HalfScreenDismissAnimator.swift
//  CocoaLumberjack
//
//  Created by admin on 2023/11/22.
//

import Foundation
open class HalfScreenDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            // 设置半屏 View Controller 的最终位置
            fromView.frame = CGRect(x: 0, y: containerView.frame.height, width: containerView.frame.width, height: containerView.frame.height/2)
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
}

