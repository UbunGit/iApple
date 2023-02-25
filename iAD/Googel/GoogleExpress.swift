//
//  60.swift
//  UGDLNA
//
//  Created by mac on 2023/1/31.
//

import Foundation
import GoogleMobileAds

class GoogleExpress:NSObject{
    
    var id:String
    var fineshBlock:((_ status:ADFineshStatus)->())? = nil
    var subViewcontroller:UIViewController? = nil
    var splashad:GADAppOpenAd? = nil
    var adsize = GADAdSizeLargeBanner
    var bannerView: GADBannerView!

    
    init(id:String) {
        self.id = id
    }

    func load(rootvc:UIViewController){
        
        bannerView = GADBannerView(adSize: adsize)
        bannerView.adUnitID = id
        bannerView.rootViewController = subViewcontroller
        bannerView.load(GADRequest())
        bannerView.delegate = self
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


//class GoogleExpressTableCell:UITableViewCell{
//    var googleExpress: GoogleExpress? = nil{
//        didSet{
//            guard let googleExpress = googleExpress else {return}
//            contentView.addSubview(googleExpress.bannerView)
//            googleExpress.bannerView.snp.makeConstraints { make in
//                make.edges.equalToSuperview()
//            }
//        }
//    }
//}
//
//class GoogleExpressCollectionViewCell:UICollectionViewCell{
//    var googleExpress: GoogleExpress? = nil{
//        didSet{
//            guard let googleExpress = googleExpress else {return}
//            contentView.addSubview(googleExpress.bannerView)
//            googleExpress.bannerView.snp.makeConstraints { make in
//                make.edges.equalToSuperview()
//            }
//        }
//    }
//}
//class GoogleExpressCollectionReusableView:UICollectionReusableView{
//    var googleExpress: GoogleExpress? = nil{
//        didSet{
//            guard let googleExpress = googleExpress else {return}
//            addSubview(googleExpress.bannerView)
//            googleExpress.bannerView.snp.makeConstraints { make in
//                make.edges.equalToSuperview()
//            }
//        }
//    }
//}
