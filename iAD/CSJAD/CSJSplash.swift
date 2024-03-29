//
//  Splash.swift
//  iBluetooth
//
//  Created by mac on 2023/2/22.
//

import Foundation
import BUAdSDK
class CSJSplash:NSObject{
    
    var fineshBlock:((_ status:ADFineshStatus)->())? = nil
    var willLoadingBlock:(()->())? = nil
    var didLoadingBlock:(()->())? = nil
    var subViewcontroller:UIViewController? = nil
 
    var adview: BUSplashAd!
    
    func show(vc:UIViewController,fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        self.subViewcontroller = vc
        self.fineshBlock = fineshBlock
        willLoadingBlock?()
        let size = UIScreen.main.bounds.size
        self.adview = BUSplashAd(slotID: IADConfig.shared.csj_splashID!, adSize:size )
        adview.tolerateTimeout = 8
        adview.supportCardView = true
        adview.delegate = self
        adview.loadData()
        logging.debug("csj load splash splashID:",adview.slotID)
        
    }
}

extension CSJSplash:BUSplashAdDelegate{
 
    // 返回的错误码(error)表示广告加载失败的原因，所有错误码详情请见链接Link 。
    public func splashAdLoadFail(_ splashAd: BUSplashAd, error: BUAdError?) {
        logging.error("CSJ splashAdLoadFail",error?.errorCode,error?.userInfo)
        IADConfig.shared.lastSplashErrorType = .csj
        didLoadingBlock?()
        fineshBlock?(.error)
    }
    // 广告加载成功回调
    public func splashAdLoadSuccess(_ splashAd: BUSplashAd) {
        didLoadingBlock?()
        splashAd.showSplashView(inRootViewController:subViewcontroller!)
        
    }
    public func splashAdWillShow(_ splashAd: BUSplashAd) {
        
    }
    public func splashAdDidClick(_ splashAd: BUSplashAd) {
        IADConfig.shared.lastRewardedShowType = .csj
        fineshBlock?(.finish)
    }
    public func splashAdDidClose(_ splashAd: BUSplashAd, closeType: BUSplashAdCloseType) {
        IADConfig.shared.lastRewardedShowType = .csj
        fineshBlock?(.finish)
    }
    public func splashDidCloseOtherController(_ splashAd: BUSplashAd, interactionType: BUInteractionType) {
        IADConfig.shared.lastRewardedShowType = .csj
        fineshBlock?(.finish)
    }
    // SDK渲染开屏广告渲染成功回调
    public func splashAdRenderSuccess(_ splashAd: BUSplashAd) {
        
    }
    // SDK渲染开屏广告渲染失败回调
    public func splashAdRenderFail(_ splashAd: BUSplashAd, error: BUAdError?) {
        logging.error("splashAdRenderFail",error?.errorCode,error?.userInfo)
        IADConfig.shared.lastSplashErrorType = .csj
        fineshBlock?(.error)
    }
    // 视频广告播放完毕回调
    public func splashVideoAdDidPlayFinish(_ splashAd: BUSplashAd, didFailWithError error: Error?) {
        
    }
    public func splashAdDidShow(_ splashAd: BUSplashAd) {
        
    }
    
    public func splashAdViewControllerDidClose(_ splashAd: BUSplashAd) {
        
    }
}


