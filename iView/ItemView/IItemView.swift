//
//  ISearchTextField.swift
//  AEXML
//
//  Created by mac on 2023/3/8.
//

import Foundation
import UIKit
open class IImageItemViewData{
    var image:String = "house.circle"
    var title:String = "首页"
    public init(image: String, title: String) {
        self.image = image
        self.title = title
    }
}
open class IItemView:UIStackView{
   
    public override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        alignment = .leading
        spacing = 4
        makeUI()
        makeLayout()
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public lazy var titleLab: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 12)
        value.textColor = .secondaryLabel
        return value
    }()
    
    public lazy var valueLab: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 16)
        value.textColor = .systemBackground
        return value
    }()
    
    open func makeUI() {
       
        addArrangedSubview(titleLab)
        addArrangedSubview(valueLab)
    }
    
    open func makeLayout() {
   
        
    }
}

open class IImageItemView:UIStackView{
   
    public override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        alignment = .leading
        spacing = 4
        makeUI()
        makeLayout()
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public lazy var titleLab: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 12)
        value.textColor = .secondaryLabel
        return value
    }()
    
    public lazy var imageView: UIImageView = {
        let value = UIImageView()
        value.contentMode = .center
        return value
    }()
    
    open func makeUI() {
        backgroundColor = .red
        addArrangedSubview(imageView)
        addArrangedSubview(titleLab)
    }
    
    open func makeLayout() {
   
        
    }
}
