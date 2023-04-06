//
//  GoogleSplash.swift
//  iBluetooth
//
//  Created by mac on 2023/2/22.
//

import Foundation
import GoogleMobileAds

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
                
                i_log(level: .warn, msg: "google splash Failed to load app open ad: \(error)")
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
        i_log(level: .warn, msg: "google splash didFailToPresentFullScreenContentWithError: \(error)")
        fineshBlock?(.error)
    }
    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        debugPrint("adWillPresentFullScreenContent")
       
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        debugPrint("adDidDismissFullScreenContent")
   
    }
    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
        debugPrint("adDidDismissFullScreenContent")
    }
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        debugPrint("adWillDismissFullScreenContent")
        fineshBlock?(.finish)
    }
  
}
