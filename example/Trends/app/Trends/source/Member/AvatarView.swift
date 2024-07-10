//
//  AvatarView.swift
//  Trends
//
//  Created by mac on 2023/7/15.
//

import SwiftUI
import SDWebImageSwiftUI
// 头像
struct AvatarView: View {
    var url:URL
    var size:CGFloat = 32
  
    var body: some View{
        UrlImage(url: url) { image in
            image.resizable()
                .frame(width: size, height: size, alignment: .center)
        } placeholder: {
            ActivityIndicator(.constant(true))
        }
        .cornerRadius(size/2)
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(url: URL.i_randomImageURL)
    }
}
