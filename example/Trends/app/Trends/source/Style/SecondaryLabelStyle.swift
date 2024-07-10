//
//  SecondaryLabelStyle.swift
//  Trends
//
//  Created by mac on 2023/7/15.
//

import Foundation
import SwiftUI

struct SecondaryLabelStyle:ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(
                Color(UIColor.secondaryLabel)
            )
    }
}

extension View{
    
    func secondaryLabe()->some View{
        self.modifier(SecondaryLabelStyle())
    }
}
