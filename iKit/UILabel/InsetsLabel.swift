//
//  UIImage.swift
//  Alamofire
//
//  Created by mac on 2023/4/10.
//

import Foundation
import UIKit

public class InsetsLabel:UILabel{
    public var contentInset:UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        rect.origin.x = rect.origin.x-contentInset.left
        rect.origin.y = rect.origin.y-contentInset.top
        rect.size.width = rect.size.width + contentInset.left+contentInset.right
        rect.size.height = rect.size.height + contentInset.top+contentInset.bottom
        return rect
    }
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect)
    }
}
