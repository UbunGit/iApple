//
//  Moden.swift
//  example
//
//  Created by admin on 2023/4/16.
//

import Foundation
import iApple
import RealmSwift


class RealmResourceModel:Object{
    
    @Persisted(primaryKey: true) var _id:String
    
    @Persisted var name:String
    @Persisted var sourceUrl:String
    @Persisted var series:List<RealmSeries>
    
    convenience init(media:ResourceModel) {
        self.init()
        self._id = media.id
        self.name = media.name
        self.sourceUrl = media.sourceUrl.absoluteString
    }
    
    func toMeida()->ResourceModel{
        return ResourceModel(sourceUrl: .init(string: sourceUrl)!,id: _id,name: name)
    }
}

// 系列
class RealmSeries:Object{
    @Persisted(primaryKey: true) var _id:String
    @Persisted var name:String
    @Persisted var items:List<RealmMeidaItem>
}

//
class RealmMeidaItem:Object{
    
    @Persisted(primaryKey: true) var _id:String
    @Persisted var type:Int
    @Persisted var content:String
    
    convenience init(kind:MediaKind,content:MediaContent) {
        self.init()
        self.type = kind.rawValue
        switch content{
        case .text(let value):
            self.content = value
            break
        case .image(let value):
            self.content = ""
            break
        }
    }
    var kind:MediaKind{
        return .init(rawValue: type)!
    }
    
    
    
    
    
}

enum MediaKind:Int{
    case text = 0
    case image = 1

}
enum MediaContent{
    case text(String)
    case image(String)
}

struct MediaImageItem{
    enum Kind:Int{
        case location
        case web
    }
    var urlKind:Kind
    var url: URL?
    var locName:String?
    var image: UIImage?
    var placeholderImage: URL?
    var size: CGSize = .init(width: 120, height: 120)
    

    init( image: UIImage, placeholderImage: URL? = nil, size: CGSize) {
        self.image = image
        let locNmar = try? image.save()
       
        self.urlKind = .location
        self.placeholderImage = placeholderImage
        self.size = size
    }
    
    init(url: URL, placeholderImage: URL? = nil, size: CGSize) {
        self.url = url
        self.urlKind = .web
        self.placeholderImage = placeholderImage
        self.size = size
    }
    
    enum CodingKeys: String, CodingKey {
        case urlKind, url,size,placeholderImage
    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        
////        name = try values.decode(String.self, forKey: .name)
////        age = try values.decode(Int.self, forKey: .age)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
////        try container.encode(name, forKey: .name)
////        try container.encode(age, forKey: .age)
//    }

}


