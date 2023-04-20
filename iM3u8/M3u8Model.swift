//
//  M3u8Model.swift
//  Alamofire
//
//  Created by mac on 2023/4/19.
//

import Foundation
import Alamofire

public class M3u8Model{
    
    var content:String!
    
    public init?(content: String) {
        guard content.hasPrefix("#EXTM3U")
        else{
            return nil
        }
        self.content = content
        analysis()
    }
    
    public convenience init?(path:String){
        guard  let data = try? Data.init(contentsOf: .init(fileURLWithPath: path)) else{
            return nil
        }
        guard let str = String(data: data, encoding: .utf8)
        else{
            return nil
        }
        self.init(content: str)
    }
    
    public var lines:[String] = []
    
    public var extinfs:[EXTINF] = []
    
    private func analysis(){
        lines = content.components(separatedBy: .newlines).filter { $0.count != 0}
        for i in 0..<lines.count{
            let line = lines[i]
            if line.hasPrefix("#EXTINF"){
                let data = EXTINF(info: line, url: lines[i+1])
                extinfs.append(data)
            }
        }
    }
    
}

public struct EXTINF{
    
    public var info:String
    public var url:String
    
    public var duration:Double = -1
    public var title:String? = nil
    public var params:[String:String] = [:]
    
    init(info: String, url: String) {
        
        self.info = info
        self.url = url
        
        let infopase = info.components(separatedBy: ",")
        if infopase.count == 1{
            duration = infopase.first.i_double()
        }else if infopase.count == 2{
            duration = infopase.first.i_double()
            title = infopase.last
        }else{
            duration = infopase.first.i_double()
            title = infopase.last
            let paramStr = infopase[1..<infopase.count-1].joined(separator: " ")
            paramStr.components(separatedBy: " ").forEach { item in
                let items = item.components(separatedBy: "=")
                params[items.first!] = items.last!
            }
        }
    }
    

}


