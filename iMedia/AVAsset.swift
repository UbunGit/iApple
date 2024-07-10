//
//  AVAsset.swift
//  SwiftKit
//
//  Created by mac on 2022/4/19.
//

import Foundation
import AVFoundation
struct MediaError:Error{
    var code:Int
    var msg:String
}

@objcMembers public class STSModel:NSObject,Decodable{
    var BucketName:String
    var dir:String
    var AccessKeyId:String
    var AccessKeySecret:String
    var SecurityToken:String
    var Expiration:String
    var Endpoint:String
}

@objc public enum VQMediaStatus:Int{
    case didSelect = 1001 // 选择完毕
    case willMP4    // 即将转mp4
    case didMP4    // mp4 转码成功
    case willcut    // 即将裁剪
    case didcut    // 裁剪完成
    case willSTS    // 即将获取sts信息
    case didSTS     // 获取sts信息完成
    case willUpload     // 即将上传
    case didUpload     // 即将上传
}

public extension AVAsset{
    
    /**
     AVAsset 转mp4
     */
    @objc func i_toMp4(_ exportPreset:String=AVAssetExportPresetHighestQuality,
                        topath:String? = nil,
                        filename:String? = nil,
                        finesh:@escaping ( _ avasset:URL?,_ error:Error?)->()){
        
        let topath:String = topath ?? UIApplication.shared.cachesPath.appending("CQCache")
        let filename:String = filename ?? "/\(Date().timeIntervalSince1970).mp4"
        let compatiblePresets = AVAssetExportSession.exportPresets(compatibleWith: self)
        if compatiblePresets.contains(exportPreset) == false{
  
            finesh(nil,MediaError(code: -1, msg: "无对应清晰度"))
            return
        }
        
        if FileManager.default.createPathIfNotExit(topath) == false{
           
            finesh(nil,MediaError(code: -1, msg: "创建文件夹失败"))
            return
        }
        guard let exportSession = AVAssetExportSession.init(asset: self, presetName: exportPreset)else{
         
            finesh(nil,MediaError(code: -1, msg: "初始化转码器失败"))
            return
        }
        
     
        let outurl:URL = .init(fileURLWithPath: topath.appending(filename))
       
        exportSession.outputURL = outurl
        exportSession.outputFileType = .mp4
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously(completionHandler: {
            switch exportSession.status{
            case .completed:
                finesh(outurl,nil)
                break
            default:
                finesh(nil,MediaError(code: -1, msg: "error:\(exportSession.status)"))
                break
            }
        })
        #if DEBUG
        Timer.scheduledTimer(withTimeInterval: 1, block: { timer in
            logging.debug("转mp4 进度：\(exportSession.progress)")
            if exportSession.progress>0.95{
                timer.invalidate()
            }
        }, repeats: true)
       
        #endif
    }
    
    /**
     AVAsset 裁剪
     */
    @objc func i_cut(star:Float = 0,
                      end:Float,
                      topath:String? = nil,
                      filename:String? = nil,
                      exportPreset:String=AVAssetExportPresetHighestQuality,
                      finesh:@escaping ( _ avasset:URL?,_ error:Error?)->()){
        
        let topath:String = topath ?? UIApplication.shared.cachesPath.appending("CQCache")
        let filename:String = filename ?? "/cut_\(Date().timeIntervalSince1970).mp4"
        
        let compatiblePresets = AVAssetExportSession.exportPresets(compatibleWith: self)
        if compatiblePresets.contains(exportPreset) == false{
        
            finesh(nil,MediaError.init(code: -1, msg: "无对应清晰度"))
            return
        }
        if FileManager.default.createPathIfNotExit(topath) == false{
           
            finesh(nil,MediaError.init(code: -1, msg: "创建文件夹失败"))
            return
        }
        guard let exportSession = AVAssetExportSession.init(asset: self, presetName: exportPreset) else{

            finesh(nil,MediaError.init(code: -1, msg: "初始化转码器失败"))
            return
        }
        let outurl:URL = .init(fileURLWithPath: topath.appending(filename))
        let durationTime = (end>0) ? CMTime(seconds:Double(end), preferredTimescale:  duration.timescale) : duration
        let startTime = CMTime(seconds:Double(star), preferredTimescale:  duration.timescale)
        let timerange = CMTimeRange(start: startTime, duration: durationTime)
        exportSession.timeRange = timerange
        
        exportSession.outputURL = outurl
        exportSession.outputFileType = .mp4
        exportSession.shouldOptimizeForNetworkUse = true
      
        exportSession.exportAsynchronously {
            switch exportSession.status{
            case .completed:
                finesh(outurl,nil)
                break
            default:
     
                finesh(nil,MediaError.init(code: -1, msg: "error:\(exportSession.status)"))
                break
            }
        }
        #if DEBUG
        Timer.scheduledTimer(withTimeInterval: 1, block: { timer in
          
            logging.debug("裁剪视频 进度：\(exportSession.progress)")
            if exportSession.progress>0.95{
                timer.invalidate()
            }
        }, repeats: true)
        #endif
        
    }
    
}
