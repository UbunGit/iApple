//
//  IBaseViewController.swift
//  Alamofire
//
//  Created by admin on 2023/8/15.
//

import UIKit
import SnapKit
open class IBaseViewController: UIViewController {

    open lazy var backBtn: UIButton = {
        let value = UIButton()
        value.i_radius = 12
        value.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        value.backgroundColor = .systemGroupedBackground
        value.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = .init(customView: backBtn)
        Task{
            await setUpData()
            makeUI()
            makeLayout()
        }
       

    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if navigationController?.viewControllers.count ?? 1>1{
//            navigationItem.leftBarButtonItem = .init(customView: backBtn)
//        }else{
//            navigationItem.largeTitleDisplayMode = .always
//        }
    }
    open func setUpData()async{
        
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
