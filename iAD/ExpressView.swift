//
//  ExpressView.swift
//  iApple
//
//  Created by mac on 2023/3/16.
//

import Foundation
import GoogleMobileAds

public class ExpressView:UIView{
   
    var adSize = GADAdSizeLargeBanner.size
    lazy var csjBanner: CSJBannerView = {
        let value = CSJBannerView(frame: .init(origin: .zero, size: .init(width: adSize.width, height: adSize.height)))
        value.load()
        return value
    }()
    lazy var googleBanner: GADBannerView = {
        
        let bannerView = GADBannerView(adSize:.init(size: .init(width: adSize.width, height: adSize.height), flags: 0))
        bannerView.adUnitID = ADManage.share.data.google.expressId
        bannerView.delegate = self
        bannerView.load(GADRequest())
        bannerView.rootViewController = self.viewController
        return bannerView
        
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.35){
            if ADManage.expressPlatform == .csj{
                self.addSubview(self.csjBanner)
                self.csjBanner.snp.makeConstraints({ make in
                    make.edges.equalToSuperview()
                })
            }else{
                self.addSubview(self.googleBanner)
                self.googleBanner.snp.makeConstraints({ make in
                    make.edges.equalToSuperview()
                })
            }
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

public class ExpressTableCell:UITableViewCell{
    lazy var expressView: ExpressView = {
        let value = ExpressView()
        return value
    }()
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeUI()
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func makeUI(){
        contentView.addSubview(expressView)
    }
    func makeLayout(){
        expressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

public class ExpressCollectionCell:UICollectionViewCell{
    lazy var expressView: ExpressView = {
        let value = ExpressView()
        return value
    }()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func makeUI(){
        contentView.addSubview(expressView)
    }
    func makeLayout(){
        expressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ExpressView:GADBannerViewDelegate{
    public func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      
        
    }
    
    public func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
   
    }

    public func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    public func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    public func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    public func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
}
