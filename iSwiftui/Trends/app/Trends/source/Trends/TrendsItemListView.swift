import Foundation
import SDWebImageSwiftUI

import SwiftUI
public struct TrendsItemListView:View {
    @ObservedObject var manage:TrendsItemViewListController.Manage
    var itemdidTapGesture:(_ data:TrendsData)->()
    var itemMoreTapGesture:(_ data:TrendsData)->()
    
    public var body: some View{
        
        GeometryReader { proxy in
            VStack{
                List(0..<manage.trends.count, id:\.self) { index in
                    
                    TrendsItemView(
                        trend: manage.trends[index],
                        content_w:  proxy.size.width-30, itemMoreTapGesture: itemMoreTapGesture
                    )
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
                .iRefreshable{
                    await manage.reloadData()
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



struct TrendsItemListView_Previews: PreviewProvider {
    static var previews: some View {
        
        TrendsItemListView(manage: TrendsItemViewListController.Manage()) { _ in
            
        } itemMoreTapGesture: { _ in
            
        }

    }
}
