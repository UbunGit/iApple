//
//  IADConfig.swift
//  iApple
//
//  Created by admin on 2023/9/18.
//

import Foundation
import BUAdSDK
public class IADConfig:NSObject{
    static let shared = IADConfig()
   
    // MARK: 穿山甲
    var csj_appID:String? = "5452703"
    var csj_splashID:String? = "888689796"
    var csj_rewardedID:String? = "954637653"
    
    // MARK: 谷歌
    var google_splashID:String? = "ca-app-pub-8735546255287972/1575822425"
    var google_rewardedID:String? = "ca-app-pub-3940256099942544/1712485313"
    var google_expressID:String = "ca-app-pub-3940256099942544/1712485313"
    
    override init() {
        super.init()
        let csjconfig = BUAdSDKConfiguration.configuration()
        csjconfig.appID = csj_appID
        BUAdSDKManager.start(syncCompletionHandler: {_,error in
            if let error = error{
                logging.debug(error)
            }
        })
        
    }
    var lastSplashType:ADTYPE{
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "IADConfig.lastSplashType")
        }
        get{
            let raw = UserDefaults.standard.integer(forKey: "IADConfig.lastSplashType")
            return .init(rawValue: raw) ?? ADTYPE.allCases.first!
        }
    }
    
    var lastRewardedType:ADTYPE{
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "IADConfig.lastRewardedType")
        }
        get{
            let raw = UserDefaults.standard.integer(forKey: "IADConfig.lastRewardedType")
            return .init(rawValue: raw) ?? ADTYPE.allCases.first!
        }
    }
}

public enum ADFineshStatus:Int{
    case error = 100
    case skip = 101
    case finish = 102
    case none
}
public enum ADTYPE:Int,CaseIterable{
    case csj = 1
    case google = 2
}

// MARK: 开屏
private var csj_splash=CSJSplash()
public extension UIViewController{
  
    func csj_showSplash(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        guard let _ = IADConfig.shared.csj_appID else{
            return fineshBlock(.error)
        }
        csj_splash.show(vc: self, fineshBlock: fineshBlock)
    }
    
    func googel_showSplash(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        
        guard let splashid = IADConfig.shared.google_splashID else{
            return fineshBlock(.error)
        }
        let googlesplash = GoogleSplash(id: splashid)
        googlesplash.show(vc: self, fineshBlock: fineshBlock)
        
    }
    
    func auto_showSplash(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if IADConfig.shared.lastSplashType == .csj{
            self.csj_showSplash(fineshBlock: fineshBlock)
        }else{
            self.googel_showSplash(fineshBlock: fineshBlock)
        }
    }
}

// MARK: 视频激励
private var csj_rewarder=CSJRewarded()
public extension UIViewController{
    func csj_showRewarded(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        guard let _ = IADConfig.shared.csj_rewardedID else{
            return fineshBlock(.error)
        }
        csj_rewarder.show(vc: self, fineshBlock: fineshBlock)
        
    }
    func googel_showRewarded(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        guard let rewardedID = IADConfig.shared.google_rewardedID else{
            return fineshBlock(.error)
        }
        GoogleRewarded(id: rewardedID).show(vc: self, finesh: fineshBlock)
    }
    func auto_showRewarded(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if IADConfig.shared.lastRewardedType == .csj{
            self.csj_showRewarded(fineshBlock: fineshBlock)
        }else{
            self.googel_showRewarded(fineshBlock: fineshBlock)
        }
    }
    
}
