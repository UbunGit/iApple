//
//  60.swift
//  UGDLNA
//
//  Created by mac on 2023/1/31.
//

import Foundation
import GoogleMobileAds

class GoogleExpress:UIView{
    
    var id:String
    var fineshBlock:((_ status:ADFineshStatus)->())? = nil
    var subViewcontroller:UIViewController? = nil
    var splashad:GADAppOpenAd? = nil
    var adsize = GADAdSizeLargeBanner
    lazy var bannerView: GADBannerView = {
        let bannerView = GADBannerView(adSize: adsize)
        bannerView.adUnitID = id
//        bannerView.rootViewController = subViewcontroller
        bannerView.load(GADRequest())
        bannerView.delegate = self
        return bannerView
    }()


    
    override init(frame: CGRect) {
        self.id = ADManage.share.data.google.expressId
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    func load(rootvc:UIViewController){
        
       
    }
}

extension GoogleExpress:GADBannerViewDelegate{
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      
        
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
   
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
}


