//
//  ISheetBaseViewController.swift
//  iApple
//
//  Created by admin on 2023/10/9.
//

import UIKit

open class ISheetBaseViewController: IBaseViewController {
    open lazy var closeBtn: UIButton = {
        let value = UIButton(frame: .init(origin: .zero, size: .init(width: 44, height: 44)))
        value.tintColor = .white
        value.setBackgroundImage(.init(systemName: "xmark.circle.fill"), for: .normal)
        value.setBlockFor(.touchUpInside) { _ in
            self.dismiss(animated: false)
        }
        return value
    }()
    public var contentView:UIView!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
        contentView.alpha = 0.1
        UIView.animate(withDuration: 0.35) {
            self.view.backgroundColor = .black.withAlphaComponent(0.35)
            self.contentView.alpha = 1
        }
    }
    open override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(animated)
        
    }
    open override func makeUI(){
        view.addSubview(contentView)
        view.addSubview(closeBtn)
    }
    open override func makeLayout(){
        
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-32)
            make.left.right.equalToSuperview()
        }
        closeBtn.snp.makeConstraints { make in
            make.right.bottom.equalTo(contentView).offset(-32)
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


}
