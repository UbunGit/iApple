//
//  GoogleExpress.swift
//  UGDLNA
//
//  Created by mac on 2023/1/31.
//

import Foundation
import GoogleMobileAds
// 谷歌激励
class GoogleRewarded:NSObject{
   
   
    var id:String
    var fineshBlock:((_ status:ADFineshStatus)->())? = nil
    var subViewcontroller:UIViewController? = nil
    var rewardedAd:GADRewardedAd? = nil
    init(id:String) {
        self.id = id
    }


    func show(vc:UIViewController,finesh:@escaping (_ status:ADFineshStatus)->(Void)){
        fineshBlock = finesh
        subViewcontroller = vc
        GADRewardedAd.load(withAdUnitID: id, request: GADRequest()) { ad, error in
            if let error = error {
                print("Rewarded ad failed to load with error: \(error.localizedDescription)")
                self.fineshBlock?(.error)
                return
            }
            print("Loading Succeeded")
            self.rewardedAd = ad
            ad?.fullScreenContentDelegate = self
          
            ad?.present(fromRootViewController: self.subViewcontroller!, userDidEarnRewardHandler: {
                self.fineshBlock?(.finish)
            })
        }

    }
    
    func didEarnRewardHandler(){
        let lastTime = Date().timeIntervalSince1970
        UserDefaults.standard.set(lastTime, forKey: "GoogleRewarded.lastTime")
        UserDefaults.standard.synchronize()
    }
}

extension GoogleRewarded:GADFullScreenContentDelegate{

    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Rewarded ad will be presented.")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Rewarded ad dismissed.")
    }
    
    func ad(
        _ ad: GADFullScreenPresentingAd,
        didFailToPresentFullScreenContentWithError error: Error
    ) {
        print("Rewarded ad failed to present with error: \(error.localizedDescription).")
        self.fineshBlock?(.error)
       
    }
   
}
