//
//  MemberItemView.swift
//  Trends
//
//  Created by mac on 2023/7/15.
//

import SwiftUI
import iApple

struct MemberItemView: View {
    let member:Member
    var followAction:() -> Void
    var body: some View {
        HStack{
            
            AvatarView(url: .i_randomImageURL, size: 32)
                .frame(width: 32,height: 32)
            MemberInfoView(member: member, followAction: followAction)
            Spacer()
            
        }
        
    }

}

struct MemberInfoView: View {
    @ObservedObject var member:Member
    var followAction:() -> Void
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 4){
                HStack{
                    Text(member.nickName)
                        .font(.callout)
                        .foregroundColor(
                            Color(UIColor.label)
                        )
                    if member.isBlue{
                        Image(systemName: "star.circle.fill")
                            .resizable()
                            .frame(width: 12,height: 12)
                            .colorMultiply(.blue)
                            .foregroundColor(.white)
                    }
                }
                Text(member.signature)
                    .secondaryLabe()
            }
            Spacer()
            Button(action: followAction) {
                Text(member.isFollow ? "已关注" : "关注")
                    .font(member.isFollow ? .system(size: 14,weight: .regular) : .system(size: 14,weight: .bold))
                    .foregroundColor(Color(UIColor.label))
                    .frame(width: 64,height: 32)
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary, lineWidth: 0.5)
                            .opacity(0.35)
                    )
            }

             
        }
    }

}



struct MemberItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        @ObservedObject var menber:Member = Member.mock()
        MemberItemView(member: menber) {
            menber.isFollow.toggle()
        }
    }
}
