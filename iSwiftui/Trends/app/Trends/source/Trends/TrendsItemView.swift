import Foundation
import SDWebImageSwiftUI
import SwiftUI
public struct TrendsItemView:View {
    @ObservedObject var trend:TrendsData
    var content_w:CGFloat
   
    public var body: some View{
        VStack(alignment: .leading){
            TrendsMemberView(member: trend.member) {
                
            }
            if let content = trend.content{
                Text(content)
                    .font(.system(size: 14,weight: .semibold))
                    .secondaryLabe()
            }
            if trend.images.count>0{

                MediaGridView(num: trend.images.count,maxClumeNum:4) { index,line in
                    UrlImage(url: trend.images[index], content: { image in
                        image.resizable()
                            .frame(width: itemSize.width, height: itemSize.height)
                    }, placeholder: {
                        ActivityIndicator(.constant(true))
                    })
                    .cornerRadius(4)
                    .frame(width: itemSize.width, height: itemSize.height)
                }
               
            }
            Spacer()
            
        }
    }
    
    var itemSize:CGSize{
        let maxClumeNum = 4
        let num = trend.images.count
        if num == 0{
            return .zero
        }else if num == 1{
            let w = content_w
            return .init(width: w, height: 120)
        }else if num < maxClumeNum{
            let sp = CGFloat((num-1)*8)
            let w = (content_w-sp)/CGFloat(num)
            return .init(width: w, height: w)
        }else{
            let sp = CGFloat((maxClumeNum-1)*8)
            let w = (content_w-sp)/CGFloat(maxClumeNum)
            return .init(width: w, height: w)
        }
    }
}
struct TrendsItemView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            TrendsItemView(trend: .mock(),content_w: proxy.size.width)
        }
        .padding()
        
    }
}
