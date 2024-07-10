//
//  IBaseModel.swift
//  iPods
//
//  Created by admin on 2023/9/16.
//

import Foundation

public protocol ManageDelegate:AnyObject{
    func valueDidChange()
}

open class IBaseManage:NSObject{
    
    var delegates:[ManageDelegate] = []
    
    public func register(_ delegate:ManageDelegate){
        if delegates.contains(where: { item in
            item === delegate
        }){
            return
        }
        delegates.append(delegate)
    }
    
    public func unRegister(_ delegate:ManageDelegate){
        
        delegates.removeAll { item in
            item === delegate
        }
    }
    
    // 通过调用该方法通知 delegates 值改变了
    public func notifyValueDidChange() {
        for delegate in delegates {
            delegate.valueDidChange()
        }
    }
}
