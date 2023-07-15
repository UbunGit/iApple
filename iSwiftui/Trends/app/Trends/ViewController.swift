//
//  ViewController.swift
//  Trends
//
//  Created by mac on 2023/7/14.
//

import UIKit

class BaseViewController: UIViewController {

    lazy var backBtn: UIButton = {
        let value = UIButton.init(frame: .init(x: 0, y: 0, width: 32, height: 32))
        value.i_radius = 4
        value.backgroundColor = .systemGroupedBackground.withAlphaComponent(0.15)
        value.tintColor = .white
        value.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        value.setBlockFor(.touchUpInside) {[weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
  
        return value
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController?.viewControllers.count ?? 1>1{
            navigationItem.leftBarButtonItem = .init(customView: backBtn)
        }else{
   
            navigationItem.largeTitleDisplayMode = .always
        }
    }


}

