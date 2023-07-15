//
//  MediaGridView.swift
//  Trends
//
//  Created by mac on 2023/7/15.
//

import SwiftUI
import SDWebImageSwiftUI

struct MediaGridView<C:View>:View{
    
    private var num:Int
    private var maxClumeNum:Int
 
    private let content:((_ index:Int,_ line:Int) -> C)
    var lineNum:Int{
        return (num%maxClumeNum>0 ? 1 : 0)+num/maxClumeNum
    }
   
    
    func lineNum(line:Int) -> Int{
        let p = line*maxClumeNum
        return min(num, p+maxClumeNum)
    }
    init(num: Int, maxClumeNum: Int = 3, content: @escaping (_ index:Int,_ line:Int) -> C) {
        self.num = num
        self.maxClumeNum = maxClumeNum
        self.content = content
    }
    var body: some View{
        
        VStack(alignment: .leading) {
            
            ForEach(0..<lineNum,id: \.self) { line in
                HStack(alignment: .center) {
                    ForEach(line*maxClumeNum..<(lineNum(line: line)),id: \.self) { index in
                        content(index,line)
                    }
                }
            }
        }
        
    }
}



