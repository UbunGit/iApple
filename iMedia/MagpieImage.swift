//
//  MagpieImage.swift
//  SwiftKit
//
//  Created by mac on 2022/4/19.
//

import Foundation
import UIKit

import TZImagePickerController

public struct MediaData{
    public var image:UIImage
    public var asset:PHAsset
}

 public extension UIViewController{
    
    func i_selectImage(
        config:((_ imagePicker:TZImagePickerController)->())?,
        finesh:@escaping (_ media:[MediaData]?,_ error:Error?)->()
    ){
        guard let pickVC = TZImagePickerController(maxImagesCount: 9, columnNumber: 4, delegate: nil) else{
            finesh (nil,MediaError(code: -1, msg: "图片选择出错"))
            return
        }
        // 设置默认样式
        pickVC.i_style_defual()
        // 设置上传图片pickVC样式
        pickVC.allowTakePicture = true; // 在内部显示拍照按钮
        pickVC.allowPickingVideo = false;//是否允许选择视频
        pickVC.allowPickingImage = true;//是否允许选择照片
        pickVC.allowPickingOriginalPhoto = false;//是否选择原图
        pickVC.showSelectedIndex = true; //显示图片序号
        pickVC.allowCrop = false;//是否允许裁剪
        pickVC.sortAscendingByModificationDate = true;//按时间倒序排列图片
        
        if let block = config{
            block(pickVC)
        }
        // photos 图片数组 assets资源数组 isOriginal 是否是原图
        pickVC.didFinishPickingPhotosHandle = ({ photos,assets,isOriginal in
            guard let assets = (assets) as? [PHAsset]? else{
                return finesh(nil,nil)
            }
            let meidas = assets?.enumerated().compactMap{ (index,item) in
                if let coverImage = photos?.value(at: index){
                    return  MediaData.init(image: coverImage, asset: item)
                }
                return nil
            }
            finesh(meidas,nil)
        })
        pickVC.modalPresentationStyle = .fullScreen
        self.present(pickVC, animated: true)

    }
     
     func i_selectMeidas(
         config:((_ imagePicker:TZImagePickerController)->())?,
         fineshImage:@escaping (_ cover:[UIImage]?, _ asset:[Any]?, _ error:Error?)->(),
         fineshVideo:@escaping (_ coverImage:UIImage?,_ asset:AVAsset?,_ error:Error?)->()
     ){
         guard let pickVC = TZImagePickerController(maxImagesCount: 9, columnNumber: 4, delegate: nil) else{
             fineshImage (nil,nil,MediaError(code: -1, msg: "图片选择出错"))
             return
         }
         // 设置默认样式
         pickVC.i_style_defual()
         // 设置上传图片pickVC样式
         pickVC.allowTakePicture = true; // 在内部显示拍照按钮
         pickVC.allowPickingVideo = true;//是否允许选择视频
         pickVC.allowPickingImage = true;//是否允许选择照片
         pickVC.allowPickingOriginalPhoto = false;//是否选择原图
         pickVC.showSelectedIndex = true; //显示图片序号
         pickVC.allowCrop = false;//是否允许裁剪
         pickVC.sortAscendingByModificationDate = true;//按时间倒序排列图片
         
         if let block = config{
             block(pickVC)
         }
         // photos 图片数组 assets资源数组 isOriginal 是否是原图
         pickVC.didFinishPickingPhotosHandle = ({ photos,assets,isOriginal in
             fineshImage(photos,assets,nil)
         })
        pickVC.didFinishPickingVideoHandle = ({ coverImage, phasset in
             guard let phasset = phasset else{
                 fineshVideo(nil,nil,nil)
                 return
             }
             let options = PHVideoRequestOptions()
             options.version = .original
             options.deliveryMode = .automatic
             options.isNetworkAccessAllowed = true
             PHImageManager.default().requestAVAsset(forVideo: phasset, options: nil) { avasset, audioMix, info in
                 DispatchQueue.main.async {
                     guard let avasset = avasset else{
                         fineshVideo(nil,nil,nil)
                         return
                     }
                     fineshVideo(coverImage,avasset,nil)
                 }
             }
         })
         pickVC.modalPresentationStyle = .fullScreen
         self.present(pickVC, animated: true)

     }
}
