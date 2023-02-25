//
//  iLog.swift
//  GoogleUtilities
//
//  Created by mac on 2023/2/25.
//

import Foundation

open class I_Log{

    
    struct Level{
        var rawValue:Int
        static let all:Level = .init(rawValue: 0)
        static let trace:Level = .init(rawValue: 100)
        static let debug:Level = .init(rawValue: 200)
        static let info:Level = .init(rawValue: 300)
        static let warn:Level = .init(rawValue: 400)
        static let error:Level = .init(rawValue: 500)
        static let fatal:Level = .init(rawValue: 600)
        static let off:Level = .init(rawValue: Int.max)
        
    }
    static let defual:I_Log = I_Log()
    
    var level:Level = .all
    
    var logfilePath:String{
        let path = UIApplication.shared.i_documnetPath.appending("/i_log")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path) == false{
           try! fileManager.createDirectory(at: .init(fileURLWithPath: path), withIntermediateDirectories: false)
        }
        let dateStr = Date().i_toString("yyyy-MM-dd")
        let filepath = path.appending("/\(dateStr)")
        if fileManager.fileExists(atPath: filepath) == false{
            fileManager.createFile(atPath: filepath, contents: nil)
        }
        return filepath
    }
    
   

    @available(macOS 10.15.4, iOS 13.4, watchOS 6.2, tvOS 13.4, *)
    func tofile(level:Level = .debug, msg:String){
        let data = Date().i_toString()
        let format = "\(level.rawValue) \(data) \(msg)"
        guard var msgdata = format.data(using: .utf8) else{
            return
        }
        let appendData = "\n".data(using: .utf8)!
        msgdata.append(appendData)
        let fileHandle = FileHandle(forWritingAtPath: logfilePath)
         let _ = try? fileHandle?.seekToEnd()
        fileHandle?.write(msgdata)
        try? fileHandle?.close()
    }
    
    func toConsole(level:Level = .debug, msg:String){
        #if DEBUG
        let format = "\(level.rawValue) \(msg)"
        guard var msgdata = format.data(using: .utf8) else{
            return
        }
        debugPrint(msgdata)
        #endif
    }
}

func i_log(level:I_Log.Level,msg:String){
    I_Log.defual.toConsole(msg: msg)
}
