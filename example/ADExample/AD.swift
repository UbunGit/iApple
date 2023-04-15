//
//  AD.swift
//  iBluetooth
//
//  Created by mac on 2023/3/28.
//

import Foundation
import iApple

extension ADManage{
    func config(){

        let mpath = Bundle.main.path(forResource: "ad", ofType: "json")
        guard let ldata = try? Data.init(contentsOf: .init(fileURLWithPath: mpath!)) else{
            return
        }
        if let data = try? JSONDecoder().decode(ADData.self, from: ldata){
            self.data = data
        }
        self.setUp()
    }
   
    static func update(){
        
        let url = URL(string: "https://ghproxy.com/https://raw.githubusercontent.com/UbunGit/data/main/iBluetooth/ad.json")!
        let path = UIApplication.shared.i_documnetPath.appending("/addata.json")
        let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
            
            if let localURL = localURL {
                do {
                    let data = try  Data.init(contentsOf: localURL)
                    if let ldata = try? Data.init(contentsOf: .init(fileURLWithPath: path)),
                       ldata.i_md5 == data.i_md5 {
                        return
                    }
                    debugPrint(String.init(data: data, encoding: .utf8) ?? "")
                    
                    let addata = try JSONDecoder().decode(ADData.self, from: data)
                    try data.write(to: .init(fileURLWithPath: path))
                    ADManage.splashPlatform = addata.platforms.first ?? .csj
                } catch  {
                    i_log(level: .warn, msg: "广告配置更新失败")
                    debugPrint(error)
                }
            }else{
                i_log(level: .warn, msg: "广告配置下载失败")
            }
        }
        task.resume()
    }
}
