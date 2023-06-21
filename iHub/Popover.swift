//
//  Sheet.swift
//  Pods-WallPaper
//
//  Created by mac on 2022/7/21.
//

import Foundation
import UIKit
extension UIViewController:UIPopoverPresentationControllerDelegate{
    
    public func popover( _ viewController: UIViewController,sourceView:UIView,animated: Bool) {
        viewController.modalPresentationStyle = .popover
        let popover = viewController.popoverPresentationController
        popover?.delegate = self
        popover?.sourceView = sourceView
        popover?.sourceRect = sourceView.bounds
        self.present(viewController, animated: animated)
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    public func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {

    }

    public func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}


open class PopoverTableviewPresentView<T:Any>:UIViewController,I_UITableViewProtocol{
    
    open var options:[T] = []

    public lazy var tableView: UITableView = {
        let value = UITableView(frame: .zero,style: .grouped)
        value.delegate = self
        value.dataSource = self
        value.i_registerCell(UITableViewCell.self)
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
        reoadData()
        preferredContentSize = .init(width: 240, height: tableView.contentSize.height)
    }
    open func makeUI(){
        view.addSubview(tableView)
    }
    open func makeLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    open func reoadData(){
        tableView.reloadData()
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.i_dequeueNibCell(with: UITableViewCell.self, for: indexPath)
        cell.backgroundColor = .clear
        if let rowdata = options[indexPath.row] as? String{
            cell.textLabel?.text = rowdata
        }
        return cell
    }
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}





