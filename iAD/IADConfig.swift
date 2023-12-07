//
//  IADConfig.swift
//  iApple
//
//  Created by admin on 2023/9/18.
//

import Foundation
import BUAdSDK
import GoogleMobileAds
public enum ADFineshStatus:Int{
    case error = 100
    case skip = 101
    case finish = 102
    case off = 103
    case none
}
public enum ADTYPE:Int,CaseIterable{
    case csj = 1
    case google = 2
}

public class IADConfig:NSObject{
    public static let shared = IADConfig()
   
    // MARK: 穿山甲
    public var csj_appID:String?  = nil // "5452703"
    public var csj_splashID:String?  = nil // "888689796"
    public var csj_rewardedID:String?  = nil //"954637653"
    
    // MARK: 谷歌
    public var google_splashID:String?  = nil // "ca-app-pub-8735546255287972/1575822425"
    public var google_rewardedID:String?  = nil // "ca-app-pub-3940256099942544/1712485313"
    public var google_expressID:String?  = nil //"ca-app-pub-3940256099942544/1712485313"
    
    public var ison:Bool = true
    public var splashType:ADTYPE? = nil //展示固定的广告商，如果为空，则执行auto
    public var rewardedType:ADTYPE? = nil //展示固定的广告商，如果为空，则执行auto
    
    override init() {
        super.init()
       
    }
    
    public func setup() async throws{

        await GADMobileAds.sharedInstance().start()
        return try await withUnsafeThrowingContinuation{ continuation in
            let csjconfig = BUAdSDKConfiguration.configuration()
            csjconfig.appID = csj_appID
            BUAdSDKManager.start(syncCompletionHandler: {_,error in
                if let error = error{
                    logging.debug(error)
                    continuation.resume(throwing: error)
                }else{
                    continuation.resume(returning: ())
                }
                
            })
        }
    }
    

    var lastSplashShowType:ADTYPE{
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "IADConfig.lastSplashType")
        }
        get{
            let raw = UserDefaults.standard.integer(forKey: "IADConfig.lastSplashType")
            return .init(rawValue: raw) ?? ADTYPE.allCases.first!
        }
    }
    var lastSplashErrorType:ADTYPE{
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "IADConfig.lastSplashErrorType")
        }
        get{
            let raw = UserDefaults.standard.integer(forKey: "IADConfig.lastSplashErrorType")
            return .init(rawValue: raw) ?? ADTYPE.allCases.first!
        }
    }
    var lastSplashRollType:ADTYPE{
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "IADConfig.lastSplashRollType")
        }
        get{
            let raw = UserDefaults.standard.integer(forKey: "IADConfig.lastSplashRollType")
            return .init(rawValue: raw) ?? ADTYPE.allCases.first!
        }
    }
    
    var lastRewardedShowType:ADTYPE{
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "IADConfig.lastRewardedType")
        }
        get{
            let raw = UserDefaults.standard.integer(forKey: "IADConfig.lastRewardedType")
            return .init(rawValue: raw) ?? ADTYPE.allCases.first!
        }
    }
    var lastRewardedErrorType:ADTYPE{
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "IADConfig.lastRewardedErrorType")
        }
        get{
            let raw = UserDefaults.standard.integer(forKey: "IADConfig.lastRewardedErrorType")
            return .init(rawValue: raw) ?? ADTYPE.allCases.first!
        }
    }
    var lastRewardedRollType:ADTYPE{
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "IADConfig.lastRewardedRollType")
        }
        get{
            let raw = UserDefaults.standard.integer(forKey: "IADConfig.lastRewardedRollType")
            return .init(rawValue: raw) ?? ADTYPE.allCases.first!
        }
    }
}


// MARK: 开屏
private var csj_splash=CSJSplash()
private var google_splash:GoogleSplash!
public extension UIViewController{
  
    /**
     展示穿山甲开屏广告
     */
    func csj_showSplash(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if IADConfig.shared.ison == false{
            logging.debug("广告已被你关闭")
            fineshBlock(.off)
            return
        }
        guard let _ = IADConfig.shared.csj_appID else{
            IADConfig.shared.lastSplashErrorType = .csj
            return fineshBlock(.error)
        }
        csj_splash.show(vc: self, fineshBlock: fineshBlock)
    }
    
    /**
     展示googel开屏广告
     */
    func googel_showSplash(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if IADConfig.shared.ison == false{
            logging.debug("广告已被你关闭")
            fineshBlock(.off)
            return
        }
        guard let splashid = IADConfig.shared.google_splashID else{
            IADConfig.shared.lastSplashErrorType = .google
            return fineshBlock(.error)
        }
        google_splash = GoogleSplash(id: splashid)
        google_splash.show(vc: self, fineshBlock: fineshBlock)
        
    }
    
    /**
     自动显示开屏广告
        1:如果上次展示csj失败，就自动切换到google，直到某一次google失败，再切换到csj
        2:如果没有配置google的开屏id，就展示csj的
        3:第一次展示csj
     */
    func auto_showSplash(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if IADConfig.shared.lastSplashErrorType == .csj,
           IADConfig.shared.google_splashID != nil,
           (IADConfig.shared.google_splashID?.count ?? 0 > 0)
        {
            self.googel_showSplash(fineshBlock: fineshBlock)
        }else{
            self.csj_showSplash(fineshBlock: fineshBlock)
        }
    }
    
    /**
     滚动显示开屏广告
        1:如果上次展示csj，这次换到google，
        2:如果没有配置google的开屏id，就展示csj的
        3:第一次展示csj
     */
    func roll_showSplash(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if IADConfig.shared.lastSplashRollType != .csj,
           IADConfig.shared.csj_splashID != nil,
           (IADConfig.shared.csj_splashID?.count ?? 0 > 0)
        {
            self.csj_showSplash(fineshBlock: fineshBlock)
            IADConfig.shared.lastSplashRollType = .csj
        }else{
            self.googel_showSplash(fineshBlock: fineshBlock)
            IADConfig.shared.lastSplashRollType = .google
        }
    }
    
    /**
     按配置 IADConfig.shared.splashType展示，如果==nil 按auto展示
     */
    func showSplash(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        switch IADConfig.shared.splashType{
        case .csj:
            self.csj_showSplash(fineshBlock: fineshBlock)
        case .none:
            self.googel_showSplash(fineshBlock: fineshBlock)
        case .some(.google):
            auto_showSplash(fineshBlock: fineshBlock)
        }
    }
}

// MARK: 视频激励
private var csj_rewarder=CSJRewarded()
private var google_rewarded:GoogleRewarded!
public extension UIViewController{
    
    func csj_showRewarded(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if IADConfig.shared.ison == false{
            logging.debug("广告已被你关闭")
            fineshBlock(.off)
            return
        }
        guard let _ = IADConfig.shared.csj_rewardedID else{
            IADConfig.shared.lastRewardedErrorType = .csj
            return fineshBlock(.error)
        }
        csj_rewarder.show(vc: self, fineshBlock: fineshBlock)
        
    }
    
    func googel_showRewarded(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if IADConfig.shared.ison == false{
            logging.debug("广告已被你关闭")
            fineshBlock(.off)
            return
        }
        guard let rewardedID = IADConfig.shared.google_rewardedID else{
            IADConfig.shared.lastRewardedErrorType = .google
            return fineshBlock(.error)
        }
        google_rewarded = GoogleRewarded(id: rewardedID)
        google_rewarded.show(vc: self, finesh: fineshBlock)
    }
    
    /**
     自动显示激励广告
        1:如果上次展示csj失败，就自动切换到google，直到某一次google失败，再切换到csj
        2:如果没有配置google的开屏id，就展示csj的
        3:第一次展示csj
     */
    func auto_showRewarded(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if IADConfig.shared.lastSplashErrorType == .csj,
           IADConfig.shared.google_rewardedID != nil,
           (IADConfig.shared.google_rewardedID?.count ?? 0 > 0)
        {
            self.googel_showRewarded(fineshBlock: fineshBlock)
        }else{
            self.csj_showRewarded(fineshBlock: fineshBlock)
        }
    }
    
    /**
     滚动显示
        1:如果上次展示csj，这次换到google，
        2:如果没有配置google的开屏id，就展示csj的
        3:第一次展示csj
     */
    func roll_showRewarded(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if IADConfig.shared.lastRewardedRollType != .csj,
           IADConfig.shared.google_rewardedID != nil,
           (IADConfig.shared.google_rewardedID?.count ?? 0 > 0)
        {
            self.csj_showRewarded(fineshBlock: fineshBlock)
            IADConfig.shared.lastRewardedRollType = .csj
        }else{
            self.googel_showRewarded(fineshBlock: fineshBlock)
            IADConfig.shared.lastRewardedRollType = .google
        }
    }
    
    /**
     按配置 IADConfig.shared.rewardedType展示，如果==nil 按auto展示
     */
    func showRewarded(fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        
        switch IADConfig.shared.rewardedType{
        case .csj:
            self.csj_showRewarded(fineshBlock: fineshBlock)
        case .none:
            self.googel_showRewarded(fineshBlock: fineshBlock)
        case .some(.google):
            auto_showRewarded(fineshBlock: fineshBlock)
        }
    }
    
}
