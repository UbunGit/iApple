//
//  MagpieAudio.swift
//  SwiftKit
//
//  Created by mac on 2022/4/29.
//

import Foundation

public  extension UIViewController{
    
   @objc func uploadAudioFile(
        type:String,
        url:String,
        statusChange:((_ status:VQMediaStatus)->())? = nil,
        finesh:@escaping (_ url:String?,_ error:Error?)->()
    ){
//        AF.api_mediaSts(type: type)
//            .i_response(type: [String:Any].self) { result in
//                statusChange?(.didSTS)
//                switch result{
//                case .failure(let error):
//                    log("音频上传 获取sts错误",level: .error)
//                    finesh(nil,error)
//                    break
//                case .success(let value):
//                    
//                    guard let stsdata = STSModel.model(withJSON: value) else{
//                        log("音频上传 sts转model错误", level: .error)
//                        finesh(nil,SwiftKitError(debugmsg: "数据解析错误", code: -1))
//                        return
//                    }
//                    log("音频上传 开始上传音频", level: .info)
//                    statusChange?(.willUpload)
//                    guard
//                        let url = URL.init(string: url),
//                        let audioData = try? Data(contentsOf: url) else{
//                        finesh(nil,SwiftKitError(debugmsg: "上传数据为空", code: -1))
//                        return
//                        
//                    }
//                    statusChange?(.willUpload)
//                    AF.api_ossUpload(stsdata, data: audioData, filetype: ".mp3") { progress in
//                        
//                    } finesh: { result, error in
//                        statusChange?(.didUpload)
//                        if error != nil{
//                            log("音频上传 上传到服务器出错\(error)", level: .error)
//                            finesh(nil,error)
//                            return
//                        }
//                        log("图片选择 上传完成", level: .info)
//                        finesh(result,nil)
//                    }
//                }
//            }
    }
}
