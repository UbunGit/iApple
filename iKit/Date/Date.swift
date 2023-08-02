//
//  Date.swift
//  iApple
//
//  Created by mac on 2023/2/25.
//

import Foundation
public extension Date{
    
    func i_dateString(_ format:String="yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        //        formatter.locale = locale
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
    
    static func fromAppleServer(dateString: String) -> Date? {
        let seperated = dateString.components(separatedBy: " ")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: seperated.last!)
        let dateObject = dateFormatter.date(from: (seperated.dropLast()).joined(separator: " "))
        return dateObject
    }
    
    
    var isToday:Bool{
        
        let now = Calendar.current.dateComponents([.year,.month,.day], from: Date())
        let se = Calendar.current.dateComponents([.year,.month,.day], from: self)
        return now == se
    }
    
}

public extension String{
    
    func i_date(_ formatter:String = "yyyy-MM-dd HH:mm:ss") -> Date{
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = formatter
        guard let date = dateformatter.date(from: self) else {
            return Date()
        }
        
        return date
    }
}
