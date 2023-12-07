//
//  HalfScreenPresentationController.swift
//  CocoaLumberjack
//
//  Created by admin on 2023/11/22.
//

import Foundation
open class HalfScreenPresentationController: UIPresentationController, UIGestureRecognizerDelegate {
    
    public var backgroundColor = UIColor.black.withAlphaComponent(0.35)
    var autoDismiss:Bool = true
    var presentationHeight:CGFloat = 500
    
    private lazy var dismissPanGesture: UIPanGestureRecognizer = {
        let value = UIPanGestureRecognizer.init(target: self, action: #selector(handleDismissPanGesture(_ :)))
        value.delegate = self
        return value
    }()
    
    open override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return CGRect.zero }
        
        // 设置半屏 View Controller 的大小和位置
        return CGRect(x: 0, y: presentationHeight, width: containerView.frame.width, height: presentationHeight)
    }
    
    open override func presentationTransitionWillBegin() {
        guard let containerView = containerView,
              let presentedView = presentedView else { return }
        
        // 将半屏 View Controller 的视图添加到容器视图中
        containerView.addSubview(presentedView)
        
        // 设置半屏 View Controller 的蒙板视图
        let dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = backgroundColor
        dimmingView.alpha = 0.0
        containerView.insertSubview(dimmingView, at: 0)
        
        // 添加蒙板视图的动画效果
        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (_) in
                dimmingView.alpha = 1.0
            }, completion: nil)
        } else {
            dimmingView.alpha = 1.0
        }
        presentedView.i_shadow(shadowColor: .systemBackground,offset: .init(width: 4, height: -4))
        dimmingView.addGestureRecognizer(dismissPanGesture)
    }
    
    open override func dismissalTransitionWillBegin() {
      
        // 移除蒙板视图的动画效果
        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (_) in
                self.presentedView?.alpha = 0.0
            }, completion: nil)
        } else {
            self.presentedView?.alpha = 0.0
        }
    }
    
    open override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            // 移除半屏 View Controller 的视图
            presentedView?.removeFromSuperview()
        }
    }
    
    
    @objc private func handleDismissPanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let containerView = containerView,
              let presentedView = presentedView else { return }
        
        let translation = gesture.translation(in: presentedView.superview)
        let progress = abs(translation.y / presentedView.frame.height)
        
        switch gesture.state {
        case .began:
            break
        case .changed:
            debugPrint(translation.y)
            let containerView_half = presentationHeight
            let presentedView_y =  containerView_half+translation.y
            presentedViewController.view.frame.origin.y = presentedView_y
            presentedViewController.view.frame.size.height = containerView.frame.height-presentedView_y
            let alpha = 1+(containerView_half - presentedView_y)/containerView_half
            presentedView.alpha = alpha

        case .ended, .cancelled:
            let velocity = gesture.velocity(in: presentedView.superview)
            
            
            if (translation.y > 0 && progress >= 0.5)
                || velocity.y > presentationHeight
            {
                // 手指向下滑动超过一半或速度超过阈值时，执行消失动画
                presentedViewController.dismiss(animated: true, completion: nil)
            } else {

                let containerView_half = presentationHeight
                UIView.animate(withDuration: 0.35) {
                    presentedView.frame.origin.y = containerView_half
                    presentedView.frame.size.height = containerView_half
                    presentedView.alpha = 1
                }
            }
        default:
            break
        }
    }

}
