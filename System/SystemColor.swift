//
//  SystemColors.swift
//  iApple
//
//  Created by mac on 2023/3/2.
//

import Foundation
struct SystemColor{
    var color:UIColor
    var title:String
    var available:String
    
    static var systemColors:[SystemColor]{
        var colors = systemColors_13
        if #available(iOS 15.0, *) {
            colors+=systemColors_15
        }
        return colors
        
    }
}


let systemColors_13:[SystemColor] = [
    .init(color: .black, title: "black",available: "all"),
    .init(color: .gray, title: "gray",available: "all"),
    .init(color: .darkGray, title: "darkGray",available: "all"),
    .init(color: .lightGray, title: "lightGray",available: "all"),
    .init(color: .white, title: "white",available: "all"),
    .init(color: .red, title: "red",available: "all"),
    .init(color: .green, title: "green",available: "all"),
    .init(color: .blue, title: "blue",available: "all"),
    .init(color: .cyan, title: "cyan",available: "all"),
    .init(color: .yellow, title: "yellow",available: "all"),
    .init(color: .magenta, title: "magenta",available: "all"),
    .init(color: .orange, title: "orange",available: "all"),
    .init(color: .purple, title: "purple",available: "all"),
    .init(color: .brown, title: "brown",available: "all"),
    .init(color: .clear, title: "clear",available: "all"),
    .init(color: .systemRed, title: "systemRed",available: "all"),
    .init(color: .systemGreen, title: "systemGreen",available: "all"),
    .init(color: .systemBlue, title: "systemBlue",available: "all"),
    .init(color: .systemOrange, title: "systemOrange",available: "all"),
    .init(color: .systemYellow, title: "systemYellow",available: "all"),
    .init(color: .systemPink, title: "systemPink",available: "all"),
    .init(color: .systemPurple, title: "systemPurple",available: "all"),
    .init(color: .systemTeal, title: "systemTeal",available: "all"),
    .init(color: .systemIndigo, title: "systemIndigo",available: "all"),
    .init(color: .systemBrown, title: "systemBrown",available: "all"),
    .init(color: .systemGray, title: "systemGray",available: "all"),
    .init(color: .systemGray2, title: "systemGray2",available: "all"),
    .init(color: .systemGray3, title: "systemGray3",available: "all"),
    .init(color: .systemGray4, title: "systemGray4",available: "all"),
    .init(color: .systemGray5, title: "systemGray5",available: "all"),
    .init(color: .systemGray6, title: "systemGray6",available: "all"),
    .init(color: .label, title: "label",available: "all"),
    .init(color: .secondaryLabel, title: "secondaryLabel",available: "all"),
    .init(color: .tertiaryLabel, title: "tertiaryLabel",available: "all"),
    .init(color: .quaternaryLabel, title: "quaternaryLabel",available: "all"),
    .init(color: .link, title: "link",available: "all"),
    .init(color: .placeholderText, title: "placeholderText",available: "all"),
    .init(color: .separator, title: "separator",available: "all"),
    .init(color: .opaqueSeparator, title: "opaqueSeparator",available: "all"),
    .init(color: .systemBackground, title: "systemBackground",available: "all"),
    .init(color: .secondarySystemBackground, title: "secondarySystemBackground",available: "all"),
    .init(color: .tertiarySystemBackground, title: "tertiarySystemBackground",available: "all"),
    .init(color: .systemGroupedBackground, title: "systemGroupedBackground",available: "all"),
    .init(color: .secondarySystemGroupedBackground, title: "secondarySystemGroupedBackground",available: "all"),
    .init(color: .tertiarySystemGroupedBackground, title: "tertiarySystemGroupedBackground",available: "all"),
    .init(color: .systemFill, title: "systemFill",available: "all"),
    .init(color: .secondarySystemFill, title: "secondarySystemFill",available: "all"),
    .init(color: .tertiarySystemFill, title: "tertiarySystemFill",available: "all"),
    .init(color: .quaternarySystemFill, title: "quaternarySystemFill",available: "all"),
    .init(color: .lightText, title: "lightText",available: "all"),
    .init(color: .darkText, title: "darkText",available: "all"),
//    .init(color: .groupTableViewBackground, title: "groupTableViewBackground",available: "all"),
]

@available(iOS 15.0, *)
let systemColors_15:[SystemColor] = [
    .init(color: .tintColor, title: "tintColor",available: "15"),
    .init(color: .systemMint, title: "systemMint",available: "15"),
    .init(color: .systemCyan, title: "systemCyan",available: "15"),
]
