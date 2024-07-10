//
//  IBaseViewController.swift
//  Alamofire
//
//  Created by admin on 2023/8/15.
//

import UIKit
import SnapKit
open class IBaseViewController: UIViewController {
    public var prefersLargeTitles:Bool = false
    public var largeTitleDisplayMode:UINavigationItem.LargeTitleDisplayMode = .automatic
    public var isNavigationBarHidden = false
    open lazy var backBtn: UIButton = {
        let value = UIButton()
        value.i_radius = 12
        value.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        value.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
        value.i_shadow()
        value.tintColor = .label
        value.backgroundColor = .systemGroupedBackground
        return value
    }()
    open lazy var backItem: UIBarButtonItem = {
        .init(customView: backBtn)
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = .init(customView: backBtn)
        makeUI()
        makeLayout()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController?.viewControllers.count ?? 1>1{
            backBtn.isHidden = false
        }else{
            backBtn.isHidden = true
        }
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationController?.navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
        navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: false)
    }
 
    open func makeUI(){
        
    }
    open func makeLayout(){
        backBtn.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
    }
    @objc open func backBtnClicked(){
        self.navigationController?.popViewController(animated: true)
    }

}
