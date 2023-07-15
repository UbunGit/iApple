//
//  Ref.swift
//  Trends
//
//  Created by mac on 2023/7/15.
//

import Foundation
import SwiftUI
struct IRefreshable:ViewModifier{
    var action: @Sendable () async -> Void
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .refreshable(action: action)
        } else {
            content
        }
    }
}

public extension View{
    
    func iRefreshable(action: @escaping @Sendable () async -> Void)-> some View{
        if #available(iOS 15.0, *) {
            return  self.modifier(IRefreshable(action: action))
        } else {
            return self
        }
    }
}
