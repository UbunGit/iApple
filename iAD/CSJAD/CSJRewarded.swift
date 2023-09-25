//
//  Rewarded.swift
//  iBluetooth
//
//  Created by mac on 2023/2/22.
//

import Foundation
import BUAdSDK
class CSJRewarded:NSObject{
    
    var isValidSucceed = false
 
    var fineshBlock:((_ status:ADFineshStatus)->())? = nil
    var subViewcontroller:UIViewController? = nil
   
    lazy var adView: BUNativeExpressRewardedVideoAd = {
        let model = BURewardedVideoModel()
        model.userId = UIApplication.shared.i_udid
        let value = BUNativeExpressRewardedVideoAd.init(slotID:IADConfig.shared.csj_rewardedID!, rewardedVideoModel: model)
        value.delegate = self
        
        return value
    }()
    func show(vc: UIViewController,fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        self.fineshBlock = fineshBlock
        self.subViewcontroller = vc
        adView.loadData()
    }
}
extension CSJRewarded:BUNativeExpressRewardedVideoAdDelegate{
    // 返回的错误码(error)表示广告加载失败的原因，所有错误码详情请见链接
    public func nativeExpressRewardedVideoAd(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, didFailWithError error: Error?) {
#if DEBUG
        debugPrint("激励广告-穿山甲ExpressRewardedVideoAd:\(error.debugDescription)")
      
#endif
        
        fineshBlock?(.error)
    }
    // 渲染失败，网络原因或者硬件原因导致渲染失败,可以更换手机或者网络环境测试。建议升级到穿山甲平台最新版本
    public func nativeExpressRewardedVideoAdViewRenderFail(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, error: Error?) {
#if DEBUG
        debugPrint("激励广告-穿山甲ExpressRewardedVideoAdViewRenderFail:\(error.debugDescription)")
#endif
        fineshBlock?(.error)
        
    }
    
    // 广告素材物料加载成功
    public func nativeExpressRewardedVideoAdDidLoad(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
#if DEBUG
        debugPrint("激励广告-穿山甲 广告素材物料加载成功")
#endif
    }
    // 视频下载完成
    public func nativeExpressRewardedVideoAdDidDownLoadVideo(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
        
#if DEBUG
        debugPrint("激励广告-穿山甲视频加载成功,开始显示")
#endif
        rewardedVideoAd.show(fromRootViewController: subViewcontroller!)
        
    }
    // 用户关闭广告时会触发此回调，注意：任何广告的关闭操作必须用户主动触发;
    public func nativeExpressRewardedVideoAdDidClose(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
#if DEBUG
        debugPrint("激励广告-穿山甲用户关闭广告")
#endif

        if isValidSucceed{
            fineshBlock?(.finish)
        }else{
            fineshBlock?(.skip)
        }
    }
    
    
    
    public func nativeExpressRewardedVideoAdServerRewardDidSucceed(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, verify: Bool) {
#if DEBUG
        debugPrint("激励广告-穿山甲触发有效激励")
#endif
        isValidSucceed = true
        //        if !ignoreTime && verify{
        //            UserDefaults.standard.setValue(Date().toString(), forKey: "ugad.rewarded.showTime")
        //        }
    }
    
    
}
