//
//  CSJBandView.swift
//  iApple
//
//  Created by mac on 2023/3/16.
//

import Foundation
import BUAdSDK
class CSJBannerView:UIView{
    
    var dataSouce:[UIView] = []
    
    
    lazy var expressAdManager: BUNativeExpressAdManager = {
        let adslot = BUAdSlot()
        adslot.id = ADManage.share.data.csj.expressId
        
        adslot.adType = .feed
        adslot.imgSize = BUSize(by: .drawFullScreen)
        adslot.position = .top
        let adsize:CGSize = self.size
        let value =  BUNativeExpressAdManager.init(slot: adslot ,adSize: adsize)
        value.delegate = self
        
        return value
    }()
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let value = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        value.i_register(cellType: ItemCell.self)
        value.isPagingEnabled = true
        value.delegate = self
        value.dataSource = self
        return value
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI(){
        addSubview(collectionView)
    }
    func makeLayout(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func load(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.35){
            self.expressAdManager.loadAdData(withCount: 3)
        }
        
    }
}

extension CSJBannerView:BUNativeExpressAdViewDelegate{
    // 加载失败
    public func nativeExpressAdFail(toLoad nativeExpressAdManager: BUNativeExpressAdManager, error: Error?) {
        ADManage.expressPlatform = ADManage.nextPlafrom(now: ADManage.expressPlatform)
        debugPrint("穿山甲信息流广告加载失败 error:\(error.debugDescription)")
        
    }
    // 渲染失败，网络原因或者硬件原因导致渲染失败,可以更换手机或者网络环境测试。建议升级到穿山甲平台最新版本
    public func nativeExpressAdViewRenderFail(_ nativeExpressAdView: BUNativeExpressAdView, error: Error?) {
 
        debugPrint("穿山甲信息流广告渲染加载失败 error:\(error)")

    }
    public func nativeExpressAdSuccess(toLoad nativeExpressAdManager: BUNativeExpressAdManager, views: [BUNativeExpressAdView]) {
        self.dataSouce = views
        collectionView.reloadData()
    }
    //  //【重要】需要在点击叉以后 在这个回调中移除视图，否则，会出现用户点击叉无效的情况
    public func nativeExpressAdView(_ nativeExpressAdView: BUNativeExpressAdView, dislikeWithReason filterWords: [BUDislikeWords]) {
        
    }
    //【重要】若开发者收到此回调，代表穿山甲会主动关闭掉广告，广告移除后需要开发者对界面进行适配
    public func nativeExpressAdViewDidRemoved(_ nativeExpressAdView: BUNativeExpressAdView) {
        self.dataSouce.removeAll()
    }
}


extension CSJBannerView:I_UICollectionViewProtocol{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSouce.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.i_dequeueReusableCell(with: ItemCell.self, for: indexPath)
        let adview = dataSouce[indexPath.row]
        adview.size = collectionView.size

        if let view = adview as? BUNativeExpressAdView{
//            view.rootViewController = self
            view.render()
           
        }
   
        cell.contentView.addSubview(adview)
//        adview.snp.remakeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        return cell
    }
    
}
extension CSJBannerView{
    class ItemCell:UICollectionViewCell{
        
    }
}
