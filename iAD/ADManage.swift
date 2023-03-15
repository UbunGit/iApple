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
    
    public var data:ADData?

    public var isShowSplash:Bool = false
    lazy var splash: Splash? = {
        guard let data = data else{
            return nil
        }
        let value = Splash(id: data.csj.splash)
        return value
    }()
    
    lazy var googleSplash: GoogleSplash? = {
        guard let data = data else{
            return nil
        }
        let value = GoogleSplash(id: data.google.splash)
        return value
    }()
    
    lazy var rewarded: Rewarded? = {
        guard let data = data else{
            return nil
        }
        let value = Rewarded(id: data.csj.rewarded)
        return value
    }()
    lazy var googleRewarded: GoogleRewarded? = {
        guard let data = data else{
            return nil
        }
        let value = GoogleRewarded(id: data.google.rewarded)
        return value
    }()
    
    
    
    
    // 初始化
    public func setUp(){
        guard let data = data else{
            return
        }
        BUAdSDKManager.setAppID(data.csj.appid)
        GADMobileAds.sharedInstance().start()
    
     
    }
    
    // 展示开屏广告
    public func showSplash(vc:UIViewController,fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        fineshBlock(.finish)
        return
        if ADManage.splashPlatform == .csj{
            splash?.show(vc: vc) { state in
                if state == .error{
                    ADManage.splashPlatform = self.nextPlafrom(now: ADManage.splashPlatform)
#if DEBUG
                    debugPrint("穿山甲开屏展示失败")
#endif
                }
                fineshBlock(state)
            }
        }else{
            googleSplash?.show(vc: vc) { state in
                if state == .error{
                    ADManage.splashPlatform =  self.nextPlafrom(now: ADManage.splashPlatform)
#if DEBUG
                    debugPrint("谷歌开屏展示失败")
#endif
                }
                fineshBlock(state)
            }
        }
    }
    
    // 展示激励广告
    public  func showRewarded(vc:UIViewController, isAlert:Bool = true,fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        
        if canShowRewarded == false{
            fineshBlock(.skip)
            return
        }
        if isAlert{
            let alert = UIAlertController(title: "提示", message: "观看广告可免费使用四小时", preferredStyle: .alert)
            alert.addAction(.init(title: "看广告", style: .default,handler: { _ in
                self.commitshowRewarded(vc: vc, fineshBlock: fineshBlock)
            }))
            
            alert.addAction(.init(title: "不用了", style: .cancel))
            
            vc.present(alert, animated: true)
        }
        self.commitshowRewarded(vc: vc, fineshBlock: fineshBlock)

    }
    
    private func commitshowRewarded(vc:UIViewController,fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if rewardPlatform == .csj{
            rewarded?.show(vc: vc) { state in
                if state == .error{
                    
                    self.rewardPlatform =  self.nextPlafrom(now: self.rewardPlatform)
#if DEBUG
                    debugPrint("穿山甲激励展示失败")
#endif
                    
                }
               
                fineshBlock(state)
            }
        }else{
            googleRewarded?.show(vc: vc) { state in
                if state == .error{
                    self.rewardPlatform =  self.nextPlafrom(now: self.rewardPlatform)
#if DEBUG
                    debugPrint("谷歌激励展示失败")
#endif
                }
               
                fineshBlock(state)
            }
        }
    }
    
    
}

extension ADManage{
    func nextPlafrom(now:ADPlatfrom)->ADPlatfrom{
        guard let data = data else{
            return .csj
        }
        if data.platforms.count<=1{
            return data.platforms.first ?? .csj
        }else{
            let index = data.platforms.firstIndex(of: now)
            let nextindex = (index ?? 0)+1
            if nextindex<data.platforms.count{
                return data.platforms[nextindex]
            }
            return data.platforms.first ?? .csj
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

        let abs = now - old - ((data?.rewarded_time ?? 10)*60)

        
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
    var rewardPlatform:ADPlatfrom{
        
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "admanage.splash")
        }
        get{
            
            let platform = UserDefaults.standard.integer(forKey: "admanage.splash")
            return .init(rawValue: platform) ?? .csj
        }
    }
    
    
    
}





public extension ADManage{
    

    var dataPath:URL?{
        
        let path = UIApplication.shared.i_documnetPath.appending("/addata.json")
        var url = URL.init(fileURLWithPath: path)
        if FileManager.default.fileExists(atPath: path) == false{
            url = Bundle.main.url(forResource: "addata", withExtension: ".json")!
        }
        return url
        
    }
    
//    func update(){
//
//        let url = URL(string: "https://ghproxy.com/https://raw.githubusercontent.com/UbunGit/data/main/addata.json")!
//        let path = UIApplication.shared.i_documnetPath.appending("/addata.json")
//        let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
//
//            if let localURL = localURL {
//                do {
//                    let data = try  Data.init(contentsOf: localURL)
//                    if let ldata = try? Data.init(contentsOf: .init(fileURLWithPath: path)),
//                       ldata.i_md5 == data.i_md5 {
//                        return
//                    }
//
//                    let addata = try JSONDecoder().decode(ADData.self, from: data)
//                    try data.write(to: .init(fileURLWithPath: path))
//                    self.splashPlatform = addata.platforms.first ?? .csj
//                } catch  {
//                    i_log(level: .warn, msg: "广告配置更新失败")
//                    debugPrint(error)
//                }
//            }else{
//                i_log(level: .warn, msg: "广告配置下载失败")
//            }
//        }
//        task.resume()
//    }
}



