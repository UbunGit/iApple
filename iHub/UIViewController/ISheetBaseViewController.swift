//
//  ISheetBaseViewController.swift
//  iPods
//
//  Created by admin on 2023/10/9.
//

import UIKit

open class ISheetBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    private var content_y:CGFloat = 0
    open lazy var closeBtn: UIButton = {
        let value = UIButton(frame: .init(origin: .zero, size: .init(width: 44, height: 44)))
        value.i_radius = 16
        value.tintColor = .label
        value.setBackgroundImage(.init(systemName: "xmark.circle"), for: .normal)
        value.setBlockFor(.touchUpInside) {[weak self] _ in
            self?.dismiss(animated: false)
        }
        return value
    }()
   
    public var contentView:UIView!
    lazy var bgView: UIView = {
        let value = UIView()
        value.backgroundColor = .systemBackground
        return value
    }()
    
    private lazy var dismissPanGesture: UIPanGestureRecognizer = {
        let value = UIPanGestureRecognizer.init(target: self, action: #selector(handleDismissPanGesture(_ :)))
        value.delegate = self
        return value
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
        contentView.alpha = 0.1
        view.addGestureRecognizer(dismissPanGesture)
        UIView.animate(withDuration: 0.35) {
            self.view.backgroundColor = .black.withAlphaComponent(0.35)
            self.contentView.alpha = 1
        }
    }
    open override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(animated)
        
    }
    open func makeUI(){
        view.addSubview(bgView)
        bgView.addSubview(closeBtn)
        bgView.addSubview(contentView)
    }
    open func makeLayout(){
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(-44)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(bgView).offset(12)
            make.trailing.equalTo(bgView).offset(-12)
            make.size.equalTo(32)
        }
    }
    open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.35) {
            self.contentView.alpha = 0
            self.view.alpha = 0
        } completion: { _ in
            super.dismiss(animated: false, completion: completion)
        }
    }
    
    @objc private func handleDismissPanGesture(_ gesture: UIPanGestureRecognizer) {
        
        
        let translation = gesture.translation(in: view)
        let progress = abs(translation.y / view.frame.height)
        
        switch gesture.state {
        case .began:
            content_y = bgView.frame.minY
            break
        case .changed:
            debugPrint(translation.y)
            let containerView_half = view.bounds.height/2
            let presentedView_y =  containerView_half+translation.y
            let y = content_y+translation.y
            bgView.layer.frame = .init(origin: .init(x: 0, y: y), size: .init(width: view.width, height: view.bounds.height-y))
            let alpha = 1+(containerView_half - presentedView_y)/containerView_half
            bgView.alpha = max(0.5, alpha)

        case .ended, .cancelled:
      
            if (translation.y > 0 && progress >= 0.3){
                // 手指向下滑动超过一半或速度超过阈值时，执行消失动画
                self.dismiss(animated: true, completion: nil)
            } else {
                bgView.layer.frame = .init(origin: .init(x: 0, y: content_y), size: .init(width: view.width, height: view.bounds.height-content_y))
                bgView.alpha = 1
            }
        default:
            break
        }
    }

}
