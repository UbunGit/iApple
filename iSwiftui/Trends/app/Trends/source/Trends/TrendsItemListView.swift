import Foundation
import SDWebImageSwiftUI

import SwiftUI
public struct TrendsItemListView:View {
    @ObservedObject var manage:Manage = Manage()
    var itemdidTapGesture:(_ data:TrendsData)->()
   
    public var body: some View{
        
        GeometryReader { proxy in
            VStack{
                List(0..<manage.trends.count, id:\.self) { index in
                    
                    TrendsItemView(trend: manage.trends[index], content_w:  proxy.size.width-30)
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


extension TrendsItemListView{
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

struct TrendsItemListView_Previews: PreviewProvider {
    static var previews: some View {
        
        TrendsItemListView { data in
            
        }
    }
}
