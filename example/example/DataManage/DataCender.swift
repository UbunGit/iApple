//
//  DataCender.swift
//  example
//
//  Created by mac on 2023/4/15.
//

import Foundation
import iApple
import RealmSwift
import Alamofire

extension Notification.Name{
    static let mediasDidUpdate:Notification.Name = .init("mediasDidUpdate")
    static let mediasInser:Notification.Name = .init("mediasInser")
}
class DataCenter{
    static let share = DataCenter()
    
    var resources:[ResourceModel] = []
    
    init(){
        
        reloadData()
    }
    func reloadData(){
        reloadMedias()
    }
    func saveContext(){
        
    }
    
}

// MediaModel
extension DataCenter{
    func mediasHasItem(url:URL)->Bool{
        return  resources.contains { item in
            return url == item.sourceUrl
        }
    }
    func append(sourceUrl:URL,name:String?){
        var name:String = name ?? sourceUrl.lastPathComponent
        if name.count == 0{
            name = "未命名"
        }
        let media:ResourceModel = .init(sourceUrl: sourceUrl,name: name)
        resources.append(media)
        try! _realm.write {
            _realm.add(RealmResourceModel.init(media: media),update: .modified)
        }
        NotificationCenter.default.post(name: .mediasInser, object: nil,userInfo: ["userInfo":media])
    }
    func delete(data:ResourceModel){
        
        resources.removeAll { item in
            item.id == data.id
        }
        guard let realonj = _realm.object(ofType: RealmResourceModel.self, forPrimaryKey: data.id) else{
            return
        }
        try? _realm.write({
            
            _realm.delete(realonj)
        })
    }
    func reloadMedias() {
        let reals =  _realm.objects(RealmResourceModel.self)
        resources =  reals.map{ $0.toMeida()}
        NotificationCenter.default.post(name: .mediasDidUpdate, object: nil)
    }
    
    func downSource(url:URL) async throws{
      
        let path = await UIApplication.shared.i_documnetPath.appending("/addata.json")
        let (data, _) = try await URLSession.shared.data(from: url)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        
        

    }
}
