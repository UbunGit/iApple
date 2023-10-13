//
//  TZImagePickerController.swift
//  SwiftKit
//
//  Created by mac on 2022/4/18.
//

import Foundation
import TZImagePickerController

extension TZImagePickerController{
    
    func i_style_defual(){
        iconThemeColor = .i_accent
        allowPickingGif = false //支持GIF图
        statusBarStyle = .default
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .i_accent
        navigationBar.isTranslucent = false
        naviTitleFont = .boldSystemFont(ofSize: 17)
        naviTitleColor = .i_accent
        barItemTextFont = .systemFont(ofSize: 15)
        barItemTextColor = .i_accent
       
        showPhotoCannotSelectLayer = true;
        cannotSelectLayerColor = .white.withAlphaComponent(0.8)
        
        self.photoPickerPageUIConfigBlock = ({
            collectionView,bottomToolBar,previewButton,
            originalPhotoButton,originalPhotoLabel,
            doneButton,numberImageView,numberLabel,
            divideLine in
            
            doneButton?.setTitleColor(.i_accent, for: .disabled)
            doneButton?.setTitleColor(.i_accent, for: .normal)
            bottomToolBar?.backgroundColor = .white
            collectionView?.backgroundColor = .white
            previewButton?.setTitleColor(.i_accent, for: .normal)
            originalPhotoLabel?.textColor = .i_accent
            originalPhotoButton?.setTitleColor(.i_accent, for: .normal)
            originalPhotoButton?.setTitleColor(.i_accent, for: .selected)
            divideLine?.backgroundColor = .white
        })
        self.photoPreviewPageUIConfigBlock = ({
            collectionView,naviBar,backButton,selectButton,indexLabel,
            toolBar,originalPhotoButton,originalPhotoLabel,doneButton,
            numberImageView,numberLabel in
            doneButton?.setTitleColor(.white, for: .normal)
            collectionView?.backgroundColor = .white
        })
    }
}
