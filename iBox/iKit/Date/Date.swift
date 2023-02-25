//
//  Date.swift
//  iApple
//
//  Created by mac on 2023/2/25.
//

import Foundation
public extension Date{
    
    func i_toString(_ format:String="yyyy-MM-dd HH:mm:ss",locale:Locale=Locale.init(identifier: "zh_CN")) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = format
        let date = formatter.string(from: self)
        return date
    }
    
    // 获取周几
    func i_week()-> Int{
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: self)
        return weekDay
    }
    // 获取当月
    func i_month()-> Int{
        let myCalendar = Calendar(identifier: .gregorian)
        let month = myCalendar.component(.month, from: self)
        return month
    }
}
