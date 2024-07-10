//
//  iAsyncImageView.swift
//  Trends
//
//  Created by mac on 2023/7/15.
//

import SwiftUI
import SDWebImageSwiftUI

enum UrlImageError:Error{
    case NullImage
}
class UrlImageLoader: ObservableObject {
    @Published var image: Image?
    lazy var manage: SDWebImageManager = {
        SDWebImageManager()
    }()
    
    func load(url:URL) async throws{
        return try await withUnsafeThrowingContinuation{ continuation in
            manage.loadImage(with: url, context: nil) { _, _, _ in
                
            } completed: { image, data, error, type, isfinished, url in
                guard let uiimage:UIImage = image else{
                    continuation.resume(throwing: UrlImageError.NullImage)
                    return
                }
                self.image = Image.init(uiImage: uiimage)
                continuation.resume(returning: ())
            }
        }
    }
    
}

public struct UrlImage<I,R>: View where I:View,R:View {
    
    private let url:URL
    private let content:(Image) -> I
    private let placeholder:(() -> R)

    public init(url: URL,
                @ViewBuilder content: @escaping (Image) -> I,
                @ViewBuilder placeholder:(@escaping () -> R)
    ){
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }
    public var body: some View {
        if #available(iOS 15.0, *) {
            AsyncImage(url: url, content: content, placeholder: placeholder)
        } else {
            SDUrlImage.init(url: url, content: content, placeholder: placeholder)
        }
    }
}

struct SDUrlImage<I,R>:View where I:View,R:View{
    private let url:URL
    private let content:(Image) -> I
    private let placeholder:(() -> R)
    @ObservedObject var imgLoader = UrlImageLoader()
    init(url: URL,
         @ViewBuilder content: @escaping (Image) -> I,
         @ViewBuilder placeholder:(@escaping () -> R)
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
        load()
    }
    func load(){
        Task{
          try await imgLoader.load(url: url)
        }
    }
    public var body: some View {
        Group{
            if imgLoader.image != nil{
                content(imgLoader.image!)
            }else{
                placeholder()
            }
        }.onDisappear(){
            imgLoader.manage.cacheKey(for: url, context: nil)
        }
        
    }
}


struct UrlImage_Previews: PreviewProvider {
    static var previews: some View {

        UrlImage(url: URL.i_randomImageURL) { image in
            image.resizable()
                .frame(width: 30, height: 30, alignment: .center)
        } placeholder: {
            ActivityIndicator(.constant(true))
        }
    }
}
