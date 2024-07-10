//
//  UITableView.swift
//  iPods
//
//  Created by mac on 2023/2/25.
//

import Foundation
import UIKit
public typealias I_UITableViewProtocol = UITableViewDelegate & UITableViewDataSource

public extension UITableView{
    
    func i_registerCell( _ type: UITableViewCell.Type) {
        let className = type.i_className
        register(type, forCellReuseIdentifier: className)
    }
    
    func i_registerCells(_ type:[UITableViewCell.Type]) {
        type.forEach { i_registerCell( $0) }
    }

    func i_registernib(cellType: UITableViewCell.Type, bundle: Bundle? = nil) {
        let className = cellType.i_className
        let identifier = className.components(separatedBy: ".").last!
        let nib = UINib(nibName: identifier, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    
    func i_registernib(cellTypes: [UITableViewCell.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { i_registernib(cellType: $0, bundle: bundle) }
    }
    
    func i_dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: type.i_className, for: indexPath) as! T
    }
    
    func i_dequeueNibCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let className = type.i_className
        let identifier = className.components(separatedBy: ".").last!
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }

    
     
     func tableHeaderViewSizeToFit() {
         tableHeaderOrFooterViewSizeToFit(\.tableHeaderView)
     }

     func tableFooterViewSizeToFit() {
         tableHeaderOrFooterViewSizeToFit(\.tableFooterView)
     }

     private func tableHeaderOrFooterViewSizeToFit(_ keyPath: ReferenceWritableKeyPath<UITableView, UIView?>) {
         guard let headerOrFooterView = self[keyPath: keyPath] else { return }
         let height = headerOrFooterView
             .systemLayoutSizeFitting(CGSize(width: frame.width, height: 0),
                                      withHorizontalFittingPriority: .required,
                                      verticalFittingPriority: .fittingSizeLevel).height
         guard headerOrFooterView.frame.height != height else { return }
         headerOrFooterView.frame.size.height = height
         self[keyPath: keyPath] = headerOrFooterView
     }

     func deselectSelectedRow(animated: Bool) {
         guard let indexPathForSelectedRow = indexPathForSelectedRow else { return }
         deselectRow(at: indexPathForSelectedRow, animated: animated)
     }

  
}


public extension UITableView{
    func i_registHeader(_ type: UITableViewHeaderFooterView.Type){
        let className = type.i_className
        self.register(type, forHeaderFooterViewReuseIdentifier:className)
    }
    func i_dequeueHeader<T: UITableViewHeaderFooterView>(_ type: T.Type)->T{
        let className = type.i_className
        return self.dequeueReusableHeaderFooterView(withIdentifier: className) as! T
    }
    
    func i_registFooter(_ type: UITableViewHeaderFooterView.Type){
        let className = type.i_className
        self.register(type, forHeaderFooterViewReuseIdentifier:className)
    }
    func i_dequeueFooter<T: UITableViewHeaderFooterView>(_ type: T.Type)->T{
        let className = type.i_className
        return self.dequeueReusableHeaderFooterView(withIdentifier: className) as! T
    }
    
}
