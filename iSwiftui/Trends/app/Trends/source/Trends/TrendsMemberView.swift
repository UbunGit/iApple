//
//  TrendsMemberView.swift
//  Trends
//
//  Created by mac on 2023/7/15.
//

import SwiftUI
struct TrendsMemberView: View {
    let member:Member
    var moreAction:() -> Void
    var body: some View {
        HStack{
            
            AvatarView(url: .i_randomImageURL, size: 32)
            TrendsMemberInfoView(menber: member, moreAction: moreAction)
            Spacer()
            
        }
        
    }
}
struct TrendsMemberInfoView: View {
    var menber:Member
    var moreAction:() -> Void
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 4){
                Text(menber.nickName)
                    .font(.callout)
                    .foregroundColor(
                        Color(UIColor.label)
                    )
                Text(menber.signature)
                    .secondaryLabe()
            }
            Spacer()
            HStack(alignment: .top){
                Text(Date().i_dateString("MM/dd"))
                    .font(.system(size: 12))
                    .foregroundColor(
                        Color(UIColor.secondaryLabel)
                    )
             
                Button(action:moreAction) {
                    Image.init(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .colorMultiply(.secondary)
                        .frame(width: 12,height: 12)
                }
            }
        }
    }
}

struct TrendsMemberView_Previews: PreviewProvider {
    static var previews: some View {
        TrendsMemberView(member: .mock()) {
            
        }
    }
}
