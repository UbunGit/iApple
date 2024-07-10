//
//  UIcollectionView.swift
//  iPods
//
//  Created by mac on 2023/2/25.
//

import Foundation
public typealias I_UICollectionViewProtocol  = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

public extension UICollectionView{
    
    func i_register(cellType: UICollectionViewCell.Type, bundle: Bundle? = nil) {
        let className = cellType.i_className
        register(cellType, forCellWithReuseIdentifier: className)
    }
    func i_register(cellTypes: [UICollectionViewCell.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { i_register(cellType: $0, bundle: bundle) }
    }
    
    func i_registernib(cellType: UICollectionViewCell.Type, bundle: Bundle? = nil) {
        let className = cellType.i_className
        let name:String = className.components(separatedBy: ".").last ?? className
        let nib = UINib(nibName: name, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func i_registernib(cellTypes: [UICollectionViewCell.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { i_registernib(cellType: $0, bundle: bundle) }
    }
    
    func i_registerReusableView(type: UICollectionReusableView.Type,
                  ofKind kind: String,
                  bundle: Bundle? = nil) {
        
        let className = type.i_className
        register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }

    func i_registerReusableViewnib(type: UICollectionReusableView.Type,
                  ofKind kind: String,
                  bundle: Bundle? = nil) {
        let className = type.i_className
        let name:String = className.components(separatedBy: ".").last ?? className
        let nib = UINib(nibName: name, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }

    func i_registerReusableViewnib(types: [UICollectionReusableView.Type],
                  ofKind kind: String,
                  bundle: Bundle? = nil) {
        types.forEach { i_registerReusableViewnib(type: $0, ofKind: kind, bundle: bundle) }
    }

    func i_dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                      for indexPath: IndexPath) -> T {
        i_register(cellType: type)
        return dequeueReusableCell(withReuseIdentifier: type.i_className, for: indexPath) as! T
    }

    func i_dequeueReusableView<T: UICollectionReusableView>(with type: T.Type,
                                                          for indexPath: IndexPath,
                                                          ofKind kind: String) -> T {
        dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.i_className, for: indexPath) as! T
    }
}


public extension UICollectionView{
    func cellWidth(space:CGFloat,column:Int) ->CGFloat{
        var cw = self.size.width
        var space = space
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout{
            let sp = layout.sectionInset.left+layout.sectionInset.right
            cw = cw-sp
            space = max(space, layout.minimumInteritemSpacing)
        }
        let fcolumn = CGFloat(column)
        let w = (cw - space*(fcolumn-1))/fcolumn
        return w
    }
    func cellSize(space:CGFloat,column:Int,ratio:CGFloat)->CGSize{
     
        let w = cellWidth(space: space, column: column)
        let h = w/ratio
        return .init(width: w, height: h)
    }  
}

