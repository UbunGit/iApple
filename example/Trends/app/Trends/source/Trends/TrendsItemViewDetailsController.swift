//
//  TrendsItemViewDetailsController.swift
//  Trends
//
//  Created by mac on 2023/7/15.
//

import UIKit
import SwiftUI
import SDWebImageSwiftUI
struct TrendsItemViewDetails:View{
    var trend:TrendsData
    @ObservedObject var manage:Manage = Manage()
    var itemdidTapGesture:(_ data:TrendsData)->()
    var body: some View{
        VStack{
           
            
            VStack{
                List{
                    
                    TrendsItemView(trend: trend, content_w: UIScreen.main.bounds.width-24, itemMoreTapGesture: {data in
                    }
                    )
                    
                    ForEach(0..<manage.trends.count, id:\.self) { index in
                        TrendsItemView(trend: manage.trends[index], content_w:UIScreen.main.bounds.width-24, itemMoreTapGesture: {data in
                        })
                        .onTapGesture {
                            itemdidTapGesture(manage.trends[index])
                        }
                        .onAppear(){
                            if manage.isLoading ||
                                index<manage.trends.count-2 {
                                return
                            }
                            needLoadMoreData()
                        }
                    }
                    
                }
                .iRefreshable{
                    await manage.loadData()
                }
                if manage.isLoading{
                    VStack{
                        Text("正在加载数据...")
                            .font(.system(size: 10,weight: .ultraLight,design: .rounded))
                            .foregroundColor(.secondary)
                        ActivityIndicator(.constant(true))
                            .colorMultiply(.red)
                        Divider()
                    }
                    
                }
            }
            
        }
       
        .listStyle(.plain)
        .onAppear(){
            manage.loadData()
        }
    }
    func needLoadMoreData(){
        manage.loadMoreData()
    }
}
extension TrendsItemViewDetails{
    class Manage:ObservableObject{
        @Published var trends:[TrendsData] = []
        @Published var isLoading:Bool = false
        func loadData(){
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                self.trends = TrendsData.mocks(num: 10)
                self.isLoading = false
            }
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
class TrendsItemViewDetailsController: BaseViewController {

    var trend:TrendsData!
    lazy var body: UIView = {
        let value = TrendsItemViewDetails(trend: trend) { data in
            
        }
        let vc = UIHostingController(rootView: value)

        return vc.view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "回复"
        makeUI()
        makeLayout()

    }
    func makeUI(){
        view.addSubview(body)
    }
    func makeLayout(){
        body.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}
