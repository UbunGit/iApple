//
//  ShowImageCell.swift
//  iPotho
//
//  Created by mac on 2023/2/28.
//

import Foundation
import UIKit

class ShowImageCell:UICollectionViewCell{
    
    var minScale:CGFloat = 1
    var mazScale:CGFloat = 4
  
    var longPressBlock:((_ cell:ShowImageCell)->())? = nil
    
    lazy var doubleTap: UITapGestureRecognizer = {
        let value = UITapGestureRecognizer()
        value.numberOfTapsRequired = 2
        value.addTarget(self, action: #selector(doubleTapDoit))
        return value
    }()
 
    lazy var scrollView: UIScrollView = {
        let value = UIScrollView()
        value.delegate = self
        value.isPagingEnabled = false
        value.minimumZoomScale = minScale
        value.maximumZoomScale = mazScale
        value.showsHorizontalScrollIndicator = false
        value.showsVerticalScrollIndicator = false
        return value
    }()
    
    lazy var imageView: UIImageView = {
        let value = UIImageView()
        value.center = self.center
        value.isUserInteractionEnabled = true
        value.addGestureRecognizer(doubleTap)
        value.contentMode = .scaleAspectFit
        return value
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeLayout()
        let long = UILongPressGestureRecognizer.init(target: self, action: #selector(longPress))
        long.minimumPressDuration = 1.5
        long.numberOfTouchesRequired = 1
        self.addGestureRecognizer(long)


    }
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func makeUI(){
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
 
    }
    func makeLayout(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
       
    }
    func zoomRectForScale(scrollview: UIScrollView, scale: CGFloat,center: CGPoint) -> CGRect {
        var zoomRect: CGRect = CGRect()
        zoomRect.size.height = scrollview.frame.size.height / scale
        zoomRect.size.width = scrollview.frame.size.width / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
   
    // 双击手势
    @objc func doubleTapDoit(tap:UITapGestureRecognizer){
        var newscale : CGFloat = 0
        guard let scroll = tap.view?.superview as? UIScrollView else {
            return
        }
        if scroll.zoomScale <= minScale{
            newscale = mazScale
        }else {
            newscale = minScale
        }
        
        let zoomRect = self.zoomRectForScale(scrollview: scroll,scale: newscale, center: tap.location(in: tap.view))
        
        scrollView.zoom(to: zoomRect, animated: true)
    }
    // 长按
    @objc func longPress(){
        longPressBlock?(self)
    }

}
 
extension ShowImageCell:UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {

        var centerX = self.scrollView.center.x
        var centerY = self.scrollView.center.y
        centerX = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : centerX
        centerY = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : centerY
        self.imageView.center = CGPoint(x: centerX, y: centerY)
    }
}
