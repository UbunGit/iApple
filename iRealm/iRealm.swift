//
//  Realm.swift
//  Sample
//
//  Created by mac on 2022/11/8.
//

import Foundation
import RealmSwift

public let _realm = RealmManage.share.realm

public class RealmManage{
    public static let share = RealmManage()
    let realm:Realm
    init() {
        var config = Realm.Configuration.defaultConfiguration
        config.schemaVersion =  UInt64(Date().timeIntervalSince1970)
        realm = try! Realm(configuration: config)
    }
    public func setup(){
        #if DEBUG
        NSLog("Realm初始化成功")
        #endif
    }
}


extension Object{
    public static var random:Self?{

        let datas =  _realm.objects(Self.self)
        if datas.count==0{
            return nil
        }
        let reindex = Int.random(in: 0..<datas.count)
        return datas[reindex]

    }
    
    public static func datas(page:Int=0,
                      pageNo:Int=10,
                      finesh:(_ datas:[Self])->()){
       
        let datas =  _realm.objects(Self.self)
       
        let of = page*pageNo
        if of>datas.count{
            finesh([])
        }
        let lim = min(datas.count, of+pageNo)
        var da:[Self] = []
        datas[of..<lim].forEach { item in
            da.append(item)
        }
        finesh(da)
    }
    public static var nextid:Int{
        _realm.objects(Self.self).count + Int(Date().timeIntervalSince1970)
    }

}
