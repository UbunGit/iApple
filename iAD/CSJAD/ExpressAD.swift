//
//  Express.swift
//  iBluetooth
//
//  Created by mac on 2023/2/22.
//

import Foundation
import BUAdSDK

class ExpressAD:NSObject{

    public var expressW = UIScreen.main.bounds.size.width-24
    public let expressH:CGFloat = 260
    public var views:[NSObject] = []
    var id:String
    lazy var adManager: BUNativeExpressAdManager = {
        let adslot = BUAdSlot()
        adslot.id = id
        
        adslot.adType = .feed
        adslot.imgSize = BUSize(by: .drawFullScreen)
        adslot.position = .top
        let value =  BUNativeExpressAdManager.init(slot: adslot ,adSize: .init(width: expressW, height: expressH))
        value.delegate = self
        
        return value
    }()
    init(id:String) {
    
        self.id = id
        super.init()
        reload()
    }
   
    func reload(){
        adManager.loadAdData(withCount: 3)
    }
}

extension ExpressAD:BUNativeExpressAdViewDelegate{
    // 加载失败
    public func nativeExpressAdFail(toLoad nativeExpressAdManager: BUNativeExpressAdManager, error: Error?) {
        
        debugPrint("穿山甲信息流广告加载失败 error:\(error.debugDescription)")
        
    }
    // 渲染失败，网络原因或者硬件原因导致渲染失败,可以更换手机或者网络环境测试。建议升级到穿山甲平台最新版本
    public func nativeExpressAdViewRenderFail(_ nativeExpressAdView: BUNativeExpressAdView, error: Error?) {
        
        if let index = views.firstIndex(of: nativeExpressAdView){
            views.remove(at:index)
        }
        
        debugPrint("穿山甲信息流广告渲染加载失败 error:\(error)")
        
        
    }
    public func nativeExpressAdSuccess(toLoad nativeExpressAdManager: BUNativeExpressAdManager, views: [BUNativeExpressAdView]) {
        self.views = views
    }
    //  //【重要】需要在点击叉以后 在这个回调中移除视图，否则，会出现用户点击叉无效的情况
    public func nativeExpressAdView(_ nativeExpressAdView: BUNativeExpressAdView, dislikeWithReason filterWords: [BUDislikeWords]) {

    }
    //【重要】若开发者收到此回调，代表穿山甲会主动关闭掉广告，广告移除后需要开发者对界面进行适配
    public func nativeExpressAdViewDidRemoved(_ nativeExpressAdView: BUNativeExpressAdView) {
        self.views.removeAll()
    }
}
