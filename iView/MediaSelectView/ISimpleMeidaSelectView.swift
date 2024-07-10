//
//  PathView.swift
//  CocoaLumberjack
//
//  Created by admin on 2023/12/15.
//

import Foundation
import UIKit

open class ISimpleMeidaSelectView:UIImageView{
    public override init(frame: CGRect) {
        super.init(frame: frame)
        i_border(color: .systemBackground)
        image = nil
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var image: UIImage?{
        set{
            if let value = newValue{
               
                super.image = value
                contentMode = .scaleAspectFill
            }else{
                contentMode = .center
                super.image = .plus
            }
        }
        get{
            super.image
        }
    }
   
    
    
}

