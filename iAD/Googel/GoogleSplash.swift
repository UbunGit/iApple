//
//  GoogleSplash.swift
//  iBluetooth
//
//  Created by mac on 2023/2/22.
//

import Foundation
import GoogleMobileAds
// 谷歌开屏
class GoogleSplash:NSObject{
    var id:String
    var fineshBlock:((_ status:ADFineshStatus)->())? = nil
    var willLoadingBlock:(()->())? = nil
    var didLoadingBlock:(()->())? = nil
    var subViewcontroller:UIViewController? = nil
    var splashad:GADAppOpenAd? = nil
    
    init(id:String) {
        self.id = id
    }

    func show(vc:UIViewController,fineshBlock: @escaping (_: ADFineshStatus) -> Void){
        subViewcontroller = vc
        self.fineshBlock = fineshBlock
        willLoadingBlock?()
        GADAppOpenAd.load(withAdUnitID: id, request: GADRequest()) {  appOpenAd, error in
            self.didLoadingBlock?()
            if error != nil || appOpenAd == nil{
                logging.debug("google splash Failed to load app open ad:",error)
                IADConfig.shared.lastSplashErrorType = .google
                fineshBlock(.error)
            }else{
                
                self.splashad = appOpenAd
                appOpenAd?.fullScreenContentDelegate = self
                appOpenAd?.present(fromRootViewController: vc)
            }
            
        }
    }
}

extension GoogleSplash:GADFullScreenContentDelegate{
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        logging.debug("google splash didFailToPresentFullScreenContentWithError:",error)
        IADConfig.shared.lastSplashErrorType = .google
        fineshBlock?(.error)
    }
    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        logging.debug("adWillPresentFullScreenContent")
       
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        logging.debug("adDidDismissFullScreenContent")
   
    }
    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
        logging.debug("adDidRecordClick")
    }
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        logging.debug("adWillDismissFullScreenContent")
        IADConfig.shared.lastSplashShowType = .google
        fineshBlock?(.finish)
    }
  
}
