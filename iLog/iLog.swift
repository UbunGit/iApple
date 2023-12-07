//
//  iLog.swift
//  GoogleUtilities
//
//  Created by mac on 2023/2/25.
//

import Foundation
import CocoaLumberjack
public let logging = Logger.defual
public class Logger{
    public static let defual = Logger()
    lazy var fileLogger: DDFileLogger = {
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        return fileLogger
    }()
    init(){
        DDLog.add(DDOSLogger.sharedInstance)
        DDLog.add(self.fileLogger)
        
    }
    public func debug(_ items: Any...){
        let msg = "🐜 DEBUG:".appending(items.map{"\($0)"}.joined(separator: " "))
        DDLogDebug(msg)
        
    }
    public func error(_ items: Any...){
        let msg = "🦞 ERROR:".appending(items.map{"\($0)"}.joined(separator: " "))
        DDLogError(msg)
    }
}
