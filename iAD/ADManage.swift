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
    
    struct ADItem:Codable{
        var appid:String?
        var splash:String
        var rewarded:String
        var expressId:String
    }
    var rewarded_time:Int
    var platforms:[ADPlatfrom]
    var google:ADItem
    var csj:ADItem
    
}

public class ADManage{
    
    
    
    var data:ADData
    //    lazy var data: ADData = {
    //
    //        if let dataPath = dataPath,
    //           let data = try? Data.init(contentsOf: dataPath) ,
    //           let value = try? JSONDecoder().decode(ADData.self, from: data){
    //            return value
    //        }
    //        return adData
    //
    //    }()
    
    public init(data: ADData) {
        self.data = data
    }
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
        
        BUAdSDKManager.setAppID(self.data.csj.appid)
        GADMobileAds.sharedInstance().start()
        self.update()
    }
    
    // 展示开屏广告
    public  func showSplash(vc:UIViewController,fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if splashPlatform == .csj{
            splash.show(vc: vc) { state in
                if state == .error{
                    self.splashPlatform = self.nextPlafrom(now: self.splashPlatform)
#if DEBUG
                    debugPrint("穿山甲开屏展示失败")
#endif
                }
                fineshBlock(state)
            }
        }else{
            googleSplash.show(vc: vc) { state in
                if state == .error{
                    self.splashPlatform =  self.nextPlafrom(now: self.splashPlatform)
#if DEBUG
                    debugPrint("谷歌开屏展示失败")
#endif
                }
                fineshBlock(state)
            }
        }
    }
    
    // 展示记录广告
    public  func showRewarded(vc:UIViewController,fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        
        if canShowRewarded == false{
            fineshBlock(.skip)
            return
        }
        let alert = UIAlertController(title: "提示", message: "观看广告可免费使用四小时", preferredStyle: .alert)
        alert.addAction(.init(title: "看广告", style: .default,handler: { _ in
            self.commitshowRewarded(vc: vc, fineshBlock: fineshBlock)
        }))
        
        alert.addAction(.init(title: "不用了", style: .cancel))
        
        vc.present(alert, animated: true)
    }
    
    private func commitshowRewarded(vc:UIViewController,fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        if rewardPlatform == .csj{
            rewarded.show(vc: vc) { state in
                if state == .error{
                    
                    self.rewardPlatform =  self.nextPlafrom(now: self.splashPlatform)
#if DEBUG
                    debugPrint("穿山甲激励展示失败")
#endif
                    
                }
                if state == .finish{
                    self.rewardedLastShowtime = Int(Date().timeIntervalSince1970)
                }
                fineshBlock(state)
            }
        }else{
            googleRewarded.show(vc: vc) { state in
                if state == .error{
                    self.rewardPlatform =  self.nextPlafrom(now: self.splashPlatform)
#if DEBUG
                    debugPrint("谷歌激励展示失败")
#endif
                }
                if state == .finish{
                    self.rewardedLastShowtime = Int(Date().timeIntervalSince1970)
                }
                fineshBlock(state)
            }
        }
    }
    
    
}

extension ADManage{
    func nextPlafrom(now:ADPlatfrom)->ADPlatfrom{
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
#if DEBUG
        let abs = now - old - 10 //(data.rewarded_time*60)
#else
        let abs = now - old - (data.rewarded_time*60)
#endif
        
        if abs > 0{
            return true
        }else{
            return false
        }
        
        
    }
    
    var splashPlatform:ADPlatfrom{
        
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


let adData:ADData = .init(rewarded_time: 240,
                          platforms: [.csj,.google],
                          google: .init(
                            splash: "ca-app-pub-8735546255287972/4391220272",
                            rewarded: "ca-app-pub-8735546255287972/2319041966",
                            expressId: "ca-app-pub-8735546255287972/1744326896"
                          ),
                          csj:.init(appid: "5369408",
                                    splash: "888140834",
                                    rewarded: "951379987",
                                    expressId: "951338398"
                                   )
)
public extension ADManage{
    
    public static let defual = ADManage(data: adData)
    var dataPath:URL?{
        
        let path = UIApplication.shared.i_documnetPath.appending("/addata.json")
        var url = URL.init(fileURLWithPath: path)
        if FileManager.default.fileExists(atPath: path) == false{
            url = Bundle.main.url(forResource: "addata", withExtension: ".json")!
        }
        return url
        
    }
    
    func update(){
        
        let url = URL(string: "https://ghproxy.com/https://raw.githubusercontent.com/UbunGit/data/main/addata.json")!
        let path = UIApplication.shared.i_documnetPath.appending("/addata.json")
        let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
            
            if let localURL = localURL {
                do {
                    let data = try  Data.init(contentsOf: localURL)
                    if let ldata = try? Data.init(contentsOf: .init(fileURLWithPath: path)),
                       ldata.i_md5 == data.i_md5 {
                        return
                    }
                    
                    let addata = try JSONDecoder().decode(ADData.self, from: data)
                    try data.write(to: .init(fileURLWithPath: path))
                    self.splashPlatform = addata.platforms.first ?? .csj
                } catch  {
                    i_log(level: .warn, msg: "广告配置更新失败")
                    debugPrint(error)
                }
            }else{
                i_log(level: .warn, msg: "广告配置下载失败")
            }
        }
        task.resume()
    }
}



