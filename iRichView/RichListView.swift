//
//  RichView.swift
//  iApple
//
//  Created by mac on 2023/7/13.
//

import SwiftUI

public struct RichListView: View {
   @State public var dataSouce:[RichItemProtocol] = []
    public init() {
      
    }
    public var body: some View {
        List {
            ForEach(0..<dataSouce.count,id: \.self) { index in
                RichView(data: dataSouce[index])
            }
        }
    }
}


