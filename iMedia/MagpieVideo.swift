//
//  MagpieVideo.swift
//  AFNetworking
//
//  Created by mac on 2022/4/18.
//

import Foundation
import AVFoundation
import AVFAudio
import AVKit
import TZImagePickerController


public extension UIViewController{
    
    /**
     选择视频
     */
    @objc func i_selectVideo(
        config:((_ imagePicker:TZImagePickerController)->())?,
        finesh:@escaping (_ coverImage:UIImage?,_ asset:AVAsset?,_ error:Error?)->()
    ){
        guard let pickVC = TZImagePickerController(maxImagesCount:1, columnNumber: 4, delegate: nil) else{
            finesh (nil,nil,nil)
            return
        }
        // 设置默认样式
        pickVC.i_style_defual()
        // 设置视频样式
        pickVC.allowTakeVideo = true
        pickVC.allowPickingImage = false
        pickVC.showSelectedIndex = true
        pickVC.allowPickingOriginalPhoto = false
        pickVC.sortAscendingByModificationDate = true
        
        if let block = config{
            block(pickVC)
        }
        pickVC.didFinishPickingVideoHandle = ({ coverImage, phasset in
            guard let phasset = phasset else{
                finesh(nil,nil,nil)
                return
            }
            let options = PHVideoRequestOptions()
            options.version = .original
            options.deliveryMode = .automatic
            options.isNetworkAccessAllowed = true
            PHImageManager.default().requestAVAsset(forVideo: phasset, options: nil) { avasset, audioMix, info in
                DispatchQueue.main.async {
                    guard let avasset = avasset else{
                        finesh(nil,nil,nil)
                        return
                    }
                    finesh(coverImage,avasset,nil)
                }
            }
        })
        pickVC.modalPresentationStyle = .fullScreen
        present(pickVC, animated: true)
        
    }
    
    
    /**
     选择视频并上传
     step 0 获取图片
     step 1 转mp4
     step 2 裁剪
     step 3 获取上传凭证
     step 4 oss上传
     */
    @objc func i_selectUploadvideo(
        cutbegin:Float,
        cutend:Float,
        ststype:String,
        config:((_ imagePicker:TZImagePickerController)->())?,
        statusChange:((_ status:VQMediaStatus)->())? = nil,
        finesh:@escaping (_ coverImage:UIImage?,_ url:String?,_ error:Error?)->()
    ){
        
        i_selectVideo(config: config) { image, avasset, error in
            statusChange?(.didSelect)
            logging.debug("视频选择 图片选择完成")
            if error != nil{
                logging.debug("视频选择 出现错误\(error.debugDescription)")
                finesh(nil,nil,error)
                return
            }
            guard let avasset = avasset else{
       
                logging.debug("视频选择 出现错误\(error.debugDescription)")
                finesh(nil,nil,MediaError(code: -1, msg: "未选中图片"))
                return
            }
            let time = avasset.duration
            let seconds = ceil(time.seconds)
            if seconds>Double(cutend+cutbegin) {
                let alert = UIAlertController(title: "提示", message: "视频时长大于\(cutend)秒将自动裁剪前\(cutend)秒进行上传", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "取消上传", style: .default) { alertAction in
               
                    logging.debug("视频选择 出现错误\(error.debugDescription)")
                    finesh(nil,nil,MediaError(code: -1, msg: "用户取消上传"))
                    return
                }
                let continueAction = UIAlertAction(title: "确定上传", style: .default) { alertAction in
                    self.i_toMp4(avasset: avasset, cutbegin: cutbegin, cutend: cutend, ststype: ststype, image: image, statusChange: statusChange, finesh: finesh)
                }
                alert.addAction(cancelAction)
                alert.addAction(continueAction)
                self.present(alert, animated: true)
            }else{
                self.i_toMp4(avasset: avasset, cutbegin: cutbegin, cutend: cutend, ststype: ststype, image: image, statusChange: statusChange, finesh: finesh)
            }

        }
    }
    
    func i_toMp4(avasset:AVAsset,
                  cutbegin:Float,
                  cutend:Float,
                  ststype:String,
                  image:UIImage?,
                  statusChange:((_ status:VQMediaStatus)->())? = nil,
                  finesh:@escaping (_ coverImage:UIImage?,_ url:String?,_ error:Error?)->()
    ){
        statusChange?(.willMP4)
        logging.debug("视频选择 转mp4")
        let mp4 = avasset.i_toMp4(finesh: { mp4url, error in
            statusChange?(.didMP4)
            if error != nil{
                logging.debug("视频选择 出现错误\(error.debugDescription)")
                finesh(nil,nil,error)
                return
            }
            
            guard  let url = mp4url else{
              
//                logging.debug("视频选择 出现错误\(error.debugDescription)",level: .error)
                finesh(nil,nil,MediaError(code: -1, msg: "视频为空"))
                return
            }
            let mp4asset = AVAsset.init(url: url)
            statusChange?(.willcut)
          
//            log("视频选择 裁剪...")
            mp4asset.i_cut(star: cutbegin, end: cutend) { cuturl, error in
                statusChange?(.didcut)
                if error != nil{
//                    log("视频选择 出现错误\(error.debugDescription)",level: .error)
                    finesh(nil,nil,error)
                    return
                }
                guard  let url = cuturl else{
                  
//                    logging.debug("视频选择 出现错误\(error.debugDescription)",level: .error)
                    finesh(nil,nil,MediaError(code: -1, msg: "视频为空"))
                    return
                }
                statusChange?(.willSTS)
                logging.debug("视频选择 获取sts...")
//                AF.api_mediaSts(type: ststype)
//                    .i_response(type: [String:Any].self) { result in
//                        statusChange?(.didSTS)
//                        switch result{
//                        case .failure(let error):
//                            logging.debug("视频选择 获取sts错误",level: .error)
//                            finesh(nil,nil,error)
//                            break
//                        case .success(let value):
//                            guard let stsdata = STSModel.model(withJSON: value) else{
//                                logging.debug("视频选择 获取sts转model错误", level: .error)
//                                finesh(nil,nil,MediaError(code: -1, msg: "数据解析错误"))
//                                return
//                            }
//                            do{
//                                let cutdata = try Data(contentsOf: url)
//                                statusChange?(.willUpload)
//                                logging.debug("视频选择 oss 上传...")
//                                AF.api_ossUpload(stsdata, data: cutdata, filetype: ".mp4") { progress in
//                                    logging.debug("视频选择 上传进度\(progress)", level: .info)
//                                } finesh: { result, error in
//                                    statusChange?(.didUpload)
//                                    if error != nil{
//                                        finesh(nil,nil,error)
//                                        logging.debug("视频选择 上传错误:\(error.debugDescription)", level: .error)
//                                        return
//                                    }
//                                    finesh(image,result,nil)
//                                }
//                            }catch{
//                                logging.debug("视频选择 转data:\(error.debugDescription)", level: .error)
//                                finesh(nil,nil,MediaError(code: -1, msg: "视频文件为空"))
//                            }
//                        }
//                    }
            }
        })
        
    }
  
   
    
}




extension FileManager{
    @objc func createPathIfNotExit(_ path:String)->Bool{
        var isdir: ObjCBool = ObjCBool(false)
        let isDirExist = fileExists(atPath: path, isDirectory: &isdir)
        if (isdir.boolValue && isDirExist) == false{
            
            do{
                try createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                return true
            }catch{
                return false
            }
        }else{
            return true
        }
    }
}
