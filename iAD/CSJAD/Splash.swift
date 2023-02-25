//
//  Splash.swift
//  iBluetooth
//
//  Created by mac on 2023/2/22.
//

import Foundation
import BUAdSDK
class Splash:NSObject{
   
    var id:String
    var fineshBlock:((_ status:ADFineshStatus)->())? = nil
    var subViewcontroller:UIViewController? = nil
    
    init(id: String) {
        self.id = id
    }
    lazy var adview: BUSplashAd = {
       let size = UIScreen.main.bounds.size
        let splashAdView = BUSplashAd(slotID: id, adSize:size )
        splashAdView.tolerateTimeout = 8
        splashAdView.delegate = self
        splashAdView.supportCardView = true
        return splashAdView
    }()
    func show(vc:UIViewController,fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        self.subViewcontroller = vc
        self.fineshBlock = fineshBlock
        adview.loadData()
        
    }
}
extension Splash:BUSplashAdDelegate{
 
    // 返回的错误码(error)表示广告加载失败的原因，所有错误码详情请见链接Link 。
    public func splashAdLoadFail(_ splashAd: BUSplashAd, error: BUAdError?) {
#if DEBUG
        debugPrint("穿山甲开屏广告错误:splashAdLoadFail:")
        debugPrint(error?.code)
#endif
        fineshBlock?(.error)
    }
    // 广告加载成功回调
    public func splashAdLoadSuccess(_ splashAd: BUSplashAd) {
        
        splashAd.showSplashView(inRootViewController:subViewcontroller!)
        
    }
    public func splashAdWillShow(_ splashAd: BUSplashAd) {
        
    }
    public func splashAdDidClick(_ splashAd: BUSplashAd) {
        fineshBlock?(.finish)
    }
    public func splashAdDidClose(_ splashAd: BUSplashAd, closeType: BUSplashAdCloseType) {
        fineshBlock?(.finish)
    }
    public func splashDidCloseOtherController(_ splashAd: BUSplashAd, interactionType: BUInteractionType) {
        fineshBlock?(.finish)
    }
    // SDK渲染开屏广告渲染成功回调
    public func splashAdRenderSuccess(_ splashAd: BUSplashAd) {
        
    }
    // SDK渲染开屏广告渲染失败回调
    public func splashAdRenderFail(_ splashAd: BUSplashAd, error: BUAdError?) {
#if DEBUG
        debugPrint("穿山甲开屏广告错误\(error.debugDescription)")
#endif
        
        fineshBlock?(.error)
    }
    // 视频广告播放完毕回调
    public func splashVideoAdDidPlayFinish(_ splashAd: BUSplashAd, didFailWithError error: Error) {
        
    }
    public func splashAdDidShow(_ splashAd: BUSplashAd) {
        
    }
    
    public func splashAdViewControllerDidClose(_ splashAd: BUSplashAd) {
        
    }
}
