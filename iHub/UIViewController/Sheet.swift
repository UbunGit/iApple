//
//  Sheet.swift
//  Pods-WallPaper
//
//  Created by mac on 2022/7/21.
//

import Foundation
import UIKit
extension UIViewController:UIPopoverPresentationControllerDelegate{
    
    @objc open func sheetViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.modalPresentationStyle = .popover
        viewController.popoverPresentationController?.delegate = self
        viewController.popoverPresentationController?.sourceView = self.view
        viewController.popoverPresentationController?.sourceRect = self.view.bounds
        self.present(viewController, animated: animated)
    }
}





