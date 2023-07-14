import Foundation

import SwiftUI
public struct TrendsItemListView:View {
    public init(){
        
    }
    public var body: some View{
        List {
            ForEach(0...1000,id:\.self) { index in
                TrendsItemView()
            }
        }
        .listStyle(.plain)
    }
}

struct TrendsItemListView_Previews: PreviewProvider {
    static var previews: some View {
        TrendsItemListView()
    }
}
