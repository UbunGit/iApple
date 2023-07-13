//
//  IWaterfallLayout.swift
//  Alamofire
//
//  Created by mac on 2023/7/6.
//

import Foundation
public protocol IWaterfallFlowLayoutDelegate: AnyObject {
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}

open class IWaterfallFlowLayout : UICollectionViewFlowLayout {
    // 在这里定义您的布局逻辑
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentHeight: CGFloat = 0
    
    public weak var waterfallDelegate:IWaterfallFlowLayoutDelegate? = nil
    
    public var numberOfColumns: Int = 2 // 设置列数为2
    
    open override func prepare() {
        // 在此方法中准备布局
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let columnsCount = CGFloat(numberOfColumns)
        let sp = minimumInteritemSpacing * (columnsCount - 1)
        let itemWidth = (collectionView.frame.width - sectionInset.left - sectionInset.right - sp) / columnsCount
        
        var xOffset: [CGFloat] = []
        for column in 0..<Int(numberOfColumns) {
            xOffset.append((itemWidth + minimumInteritemSpacing) * CGFloat(column))
        }
        
        var yOffset: [CGFloat] = .init(repeating: 0, count: Int(numberOfColumns))
        
        cache.removeAll()
        contentHeight = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let column = yOffset.firstIndex(of: yOffset.min() ?? 0) ?? 0
            let height = waterfallDelegate?.collectionView(collectionView, heightForItemAt: indexPath, withWidth: itemWidth) ?? 200 // 获取每个单元格的高度
            
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: itemWidth, height: height)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            
            yOffset[column] = yOffset[column] + height + minimumLineSpacing
            contentHeight = max(contentHeight, frame.maxY)
        }
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        // 返回指定索引路径的单元格布局属性
        return nil
    }
    
    open override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.frame.width ?? 0, height: contentHeight)
    }
}
