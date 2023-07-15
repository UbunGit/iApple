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

    lazy var body: UIView = {
        let vc = UIHostingController(rootView: TrendsItemListView(itemdidTapGesture: { data in
            let defvc = TrendsItemViewDetailsController()
            defvc.trend = data
            self.navigationController?.pushViewController(defvc, animated: true)
        }))
       
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
    


}
