//
//  DataCender.swift
//  example
//
//  Created by mac on 2023/4/15.
//

import Foundation
import iApple
import RealmSwift
class DataCenter{
    static let share = DataCenter()
    
    var medias:[MediaModel] = []
    
    init(){
        
        reloadData()
    }
    func reloadData(){
        reloadMedias()
    }
    func saveContext(){
        
    }
    
}
class RealmMediaModel:Object{
    
    @Persisted(primaryKey: true) var _id:String
    @Persisted var name:String
    @Persisted var sourceUrl:String
    
    convenience init(media:MediaModel) {
        self.init()
        self._id = media.id
        self.name = media.name
        self.sourceUrl = media.sourceUrl.absoluteString
    }
    
    func toMeida()->MediaModel{
        return MediaModel(sourceUrl: .init(string: sourceUrl)!,id: _id,name: name)
    }
    
    
}
// MediaModel
extension DataCenter{
    
    func append(sourceUrl:URL,name:String?){
        let name:String = name ?? sourceUrl.lastPathComponent
        let media:MediaModel = .init(sourceUrl: sourceUrl,name: name)
        medias.append(media)
        try! _realm.write {
            _realm.add(RealmMediaModel.init(media: media),update: .modified)
        }
    }
    func reloadMedias() {
        let reals =  _realm.objects(RealmMediaModel.self)
        medias =  reals.map{ $0.toMeida()}
    }
}
