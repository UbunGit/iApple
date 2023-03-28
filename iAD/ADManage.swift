//
//  ADManage.swift
//  iBluetooth
//
//  Created by mac on 2023/2/22.
//

import Foundation
import BUAdSDK
import AppTrackingTransparency
import GoogleMobileAds


public enum ADFineshStatus:Int{
    case error = 100
    case skip = 101
    case finish = 102
    case none
}



public enum ADPlatfrom:Int,Codable{
    case csj = 0
    case google
}

public struct ADData:Codable{
    
    public struct ADItem:Codable{
        var appid:String?
        var splash:String
        var rewarded:String
        var expressId:String
        
        public init(appid: String? = nil, splash: String, rewarded: String, expressId: String) {
            self.appid = appid
            self.splash = splash
            self.rewarded = rewarded
            self.expressId = expressId
        }
    }
    
    
    public var rewarded_time:Int
    public var platforms:[ADPlatfrom]
    public var google:ADItem
    public var csj:ADItem
    public var version:Int
    
    init(rewarded_time: Int, platforms: [ADPlatfrom], google: ADItem, csj: ADItem, version: Int) {
        self.rewarded_time = rewarded_time
        self.platforms = platforms
        self.google = google
        self.csj = csj
        self.version = version
    }
    
}

public class ADManage{
    
    public static let share = ADManage()
    public var data:ADData!
    
    
    public var isShowSplash:Bool = false
    
    lazy var splash: Splash = {
        
        let value = Splash(id: data.csj.splash)
        return value
    }()
    
    lazy var googleSplash: GoogleSplash = {
        
        let value = GoogleSplash(id: data.google.splash)
        return value
    }()
    
    lazy var rewarded: Rewarded = {
        
        let value = Rewarded(id: data.csj.rewarded)
        return value
    }()
    lazy var googleRewarded: GoogleRewarded = {
        
        let value = GoogleRewarded(id: data.google.rewarded)
        return value
    }()

    
    // 初始化
    public func setUp(){
        
        BUAdSDKManager.setAppID(data.csj.appid)
        GADMobileAds.sharedInstance().start()
        cutDownTimer.fireDate = Date()
    }

 
    
    
}

extension ADManage{
   static func nextPlafrom(now:ADPlatfrom)->ADPlatfrom{
        
       if ADManage.share.data.platforms.count<=1{
            return ADManage.share.data.platforms.first ?? .csj
        }else{
            let index = ADManage.share.data.platforms.firstIndex(of: now)
            let nextindex = (index ?? 0)+1
            if nextindex<ADManage.share.data.platforms.count{
                return ADManage.share.data.platforms[nextindex]
            }
            return ADManage.share.data.platforms.first ?? .csj
        }
    }
    
    
    var rewardedLastShowtime:Int{
        set{
            UserDefaults.standard.set(newValue, forKey: "admanage.rewardedLastShowtime")
        }
        get{
            let platform = UserDefaults.standard.integer(forKey: "admanage.rewardedLastShowtime")
            return platform
        }
    }
    // 是否可以展示激励广告
    var canShowRewarded:Bool{
        
        if rewardedLastShowtime == 0{
            rewardedLastShowtime = Int(Date().timeIntervalSince1970)
            return false
        }
        // 900 -800 -50 //
        let now = Int(Date().timeIntervalSince1970)
        let old = rewardedLastShowtime
        #if DEBUG
        let abs = now - old - (data.rewarded_time)
        #else
        let abs = now - old - ((data.rewarded_time)*60)
        #endif
        if abs > 0{
            return true
        }else{
            return false
        }
    }
    
    public static var splashPlatform:ADPlatfrom{
        
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "admanage.splash")
        }
        get{
            
            let platform = UserDefaults.standard.integer(forKey: "admanage.splash")
            return .init(rawValue: platform) ?? .csj
        }
    }
    // 激励广告平台
    public static var rewardPlatform:ADPlatfrom{
        
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "admanage.splash")
        }
        get{
            
            let platform = UserDefaults.standard.integer(forKey: "admanage.splash")
            return .init(rawValue: platform) ?? .csj
        }
    }
    
    // 信息流平台
    public static var expressPlatform:ADPlatfrom{
        
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "admanage.expressPlatform")
        }
        get{
            
            let platform = UserDefaults.standard.integer(forKey: "admanage.expressPlatform")
            return .init(rawValue: platform) ?? .csj
        }
    }
    
    
    
}

extension UIViewController{
    
    // 展示开屏广告
    public func showSplash(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        
        if ADManage.splashPlatform == .csj{
            ADManage.share.splash.show(vc: self) { state in
                if state == .error{
                    ADManage.splashPlatform = ADManage.nextPlafrom(now: ADManage.splashPlatform)
#if DEBUG
                    debugPrint("穿山甲开屏展示失败")
#endif
                }
                fineshBlock(state)
            }
        }else{
            ADManage.share.googleSplash.show(vc: self) { state in
                if state == .error{
                    ADManage.splashPlatform =  ADManage.nextPlafrom(now: ADManage.splashPlatform)
#if DEBUG
                    debugPrint("谷歌开屏展示失败")
#endif
                }
                fineshBlock(state)
            }
        }
    }
    
    // 展示激励广告
    public  func showRewarded(isAlert:Bool = true,fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        
        if ADManage.share.canShowRewarded == false{
            fineshBlock(.skip)
            return
        }
        if isAlert{
            let alert = UIAlertController(title: "提示", message: "观看广告可免费体验四小时", preferredStyle: .alert)
            alert.addAction(.init(title: "看广告", style: .default,handler: { _ in
                self.commitshowRewarded(fineshBlock: fineshBlock)
            }))
            alert.addAction(.init(title: "不用了", style: .cancel))
            
            self.present(alert, animated: true)
        }
        self.commitshowRewarded( fineshBlock: fineshBlock)
        
    }
    
    private func commitshowRewarded(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if ADManage.rewardPlatform == .csj{
            ADManage.share.rewarded.show(vc: self) { state in
                if state == .error{
                    
                    ADManage.rewardPlatform =  ADManage.nextPlafrom(now: ADManage.rewardPlatform)
#if DEBUG
                    debugPrint("穿山甲激励展示失败")
#endif
                    
                }
                
                fineshBlock(state)
            }
        }else{
            ADManage.share.googleRewarded.show(vc: self) { state in
                if state == .error{
                    ADManage.rewardPlatform =  ADManage.nextPlafrom(now: ADManage.rewardPlatform)
#if DEBUG
                    debugPrint("谷歌激励展示失败")
#endif
                }
                
                fineshBlock(state)
            }
        }
    }
    
}

extension Notification.Name{
    
    static let oneSecondCutDown:Notification.Name = .init("OneSecondCutDown")
}

let cutDownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
    NotificationCenter.default.post(name: .oneSecondCutDown, object: nil)
})



