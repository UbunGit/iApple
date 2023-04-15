//
//  RouterCenter.swift
//  AFNetworking
//
//  Created by mac on 2022/11/2.
//

import Foundation

@objc
public protocol I_RouterProtocol:NSObjectProtocol{
    static func routerUrl()->String
}
extension I_RouterProtocol{
    public static func routerUrl()->String{
        return ""
    }
}

@objcMembers
public class RouterCenter:NSObject{
    
  
    public static let share = RouterCenter()
    private var routerMap:[String:AnyClass] = [:]
    private override init(){
        super.init()
   
    }

    public func setup(){
        allClasses().filter { aClass in
            var subject: AnyClass? = aClass
            while let aClass = subject {
                if class_conformsToProtocol(aClass, I_RouterProtocol.self) {
                    return true
                }
                subject = class_getSuperclass(aClass)
            }
            return false
        }.forEach { aClass in
            let url = aClass.routerUrl()
            routerMap[url] = aClass
        }
#if DEBUG
        debugPrint(routerMap)
#endif
    }
    
    public func classWithUrl(url:URL)->AnyClass?{
        let urlStrs = url.absoluteString.split(separator: "?")
        guard let key = urlStrs.first else {
            return nil
        }
        let aclass: AnyClass? = routerMap[String(key)]
        #if DEBUG
        debugPrint(String(format: "classWithUrl:%@ => %@", url.absoluteString,"\(aclass.self)"))
        #endif
        return aclass
    }
    
    private func allClasses() -> [AnyClass] {
        let numberOfClasses = Int(objc_getClassList(nil, 0))
        if numberOfClasses > 0 {
            let classesPtr = UnsafeMutablePointer<AnyClass>.allocate(capacity: numberOfClasses)
            let autoreleasingClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(classesPtr)
            let count = objc_getClassList(autoreleasingClasses, Int32(numberOfClasses))
            assert(numberOfClasses == count)
            defer { classesPtr.deallocate() }
            let classes = (0 ..< numberOfClasses).map { classesPtr[$0] }
            return classes
        }
        return []
    }
    
   
}
