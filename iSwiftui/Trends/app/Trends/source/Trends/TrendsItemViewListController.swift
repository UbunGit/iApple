//
//  MemberListViewController.swift
//  Trends
//
//  Created by mac on 2023/7/15.
//

import UIKit
import SwiftUI
import SnapKit
class TrendsItemViewListController: BaseViewController {

    var manage = Manage()
    
    lazy var body: UIView = {
        let vc = UIHostingController(rootView: TrendsItemListView(
            manage: manage,
            itemdidTapGesture: { data in
            let defvc = TrendsItemViewDetailsController()
            defvc.trend = data
            self.navigationController?.pushViewController(defvc, animated: true)
        }, itemMoreTapGesture: {[weak self] data in
            self?.showMenu(data:data)
        })
                                                                 )
       
        return vc.view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
       
       
    }
    func makeUI(){
        title = "首页"
        self.view.addSubview(body)
        
    }
    func makeLayout(){
        body.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    func showMenu(data:TrendsData){
       let vc = TrendsMoreSheetViewController()
        vc.manage = manage
        vc.trend = data
        vc.tapGestureBlock = {[weak self] index in
            defer{
                self?.dismiss(animated: true)
            }
            guard let self = self else {return}
            guard let findex = manage.trends.firstIndex(where: { $0==data}) else{
                return
            }
            manage.trends.remove(at: findex)
            switch index{
            case 0:
                break
                
            case 1:
                
                break
            case 2:
                
                break
            case 3:
                let vc = TrendsReportViewController()
                vc.title = "举报"
                vc.trend = data
                self.navigationController?.pushViewController(vc, animated: true)
                break
            default:
                break
            }
        }
        vc.modalTransitionStyle = .coverVertical
        
        self.navigationController?.present(vc, animated: true)
    }


}

extension TrendsItemViewListController{
    class Manage:ObservableObject{
        @Published var trends:[TrendsData] = []
        @Published var isLoading:Bool = false
        
        func loadData(){
            if trends.count>0{
                return
            }
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                self.trends = TrendsData.mocks(num: 10)
                self.isLoading = false
            }
        }
        func reloadData(){
            trends = []
            loadData()
        }
        func loadMoreData(){
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                var datas = self.trends
                datas.append(contentsOf: TrendsData.mocks(num: 10))
                self.trends = datas
                self.isLoading = false
            }
        }
    }
}

