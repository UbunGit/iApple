//
//  IBaseScrollerStackViewController.swift
//  iPods
//
//  Created by admin on 2023/10/13.
//

import UIKit

open class IBaseScrollerStackViewController: IBaseViewController {
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
    open lazy var scrollView: UIScrollView = {
        let value = UIScrollView()
        value.contentInsetAdjustmentBehavior = .always
        value.translatesAutoresizingMaskIntoConstraints = false
        value.delaysContentTouches = false
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    open override func makeUI() {
        super.makeUI()
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    open override func makeLayout() {
        super.makeLayout()
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            stackView.heightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor),

            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
    }
}
open class IScrollerStackView:IBaseView{
    open  lazy var stackView: UIStackView = {
        let value = UIStackView()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.alignment = .center
        value.spacing = 8
        value.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        value.isLayoutMarginsRelativeArrangement = true
        return value
    }()
    open lazy var scrollView: UIScrollView = {
        let value = UIScrollView()

        value.contentInsetAdjustmentBehavior = .always
        value.translatesAutoresizingMaskIntoConstraints = false
        value.delaysContentTouches = false
        return value
    }()
    open override func makeUI() {
        super.makeUI()
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    open override func makeLayout() {
        super.makeLayout()
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            stackView.heightAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.heightAnchor),

            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
    }
}
