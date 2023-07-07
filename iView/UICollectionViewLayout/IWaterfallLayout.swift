//
//  IWaterfallLayout.swift
//  Alamofire
//
//  Created by mac on 2023/7/6.
//

import Foundation
protocol IWaterfallFlowLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}
class IWaterfallFlowLayout : UICollectionViewFlowLayout {
    // 在这里定义您的布局逻辑
    // 重写以下方法来自定义布局
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    weak var delegate:IWaterfallFlowLayoutDelegate? = nil
    override func prepare() {
        // 在此方法中准备布局
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let numberOfColumns: CGFloat = 2 // 设置列数为2
        let itemWidth = (collectionView.frame.width - sectionInset.left - sectionInset.right - (minimumInteritemSpacing * (numberOfColumns - 1))) / numberOfColumns
        
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
            let height = delegate?.collectionView(collectionView, heightForItemAt: indexPath, withWidth: itemWidth) ?? 200 // 获取每个单元格的高度
            
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: itemWidth, height: height)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            
            yOffset[column] = yOffset[column] + height + minimumLineSpacing
            contentHeight = max(contentHeight, frame.maxY)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        // 返回指定索引路径的单元格布局属性
        return nil
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.frame.width ?? 0, height: contentHeight)
    }
}
