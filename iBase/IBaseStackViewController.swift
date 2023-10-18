//
//  IBStackViewViewController.swift
//  iBudget
//
//  Created by admin on 2023/10/13.
//

import UIKit

open class IBaseStackViewController: IBaseViewController {

  open  lazy var stackView: UIStackView = {
        let value = UIStackView()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.axis = .vertical
        value.alignment = .center
        value.spacing = 16
        value.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        value.isLayoutMarginsRelativeArrangement = true
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()

    }
    open override func makeUI() {
        super.makeUI()
        view.addSubview(stackView)
    }
    open override func makeLayout() {
        super.makeLayout()
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    


}
