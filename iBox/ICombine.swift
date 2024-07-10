//
//  IBoxBaseViewController.swift
//  iPods
//
//  Created by admin on 2023/7/26.
//

import Foundation
public protocol ICombineDelegate:AnyObject{
    func valueDidChange()
}
public protocol ICombineProtocol:AnyObject {
    var delegates:[ICombineDelegate] { get set }
    func register(_ delegate:ICombineDelegate)
    func unRegister(_ delegate:ICombineDelegate)
    func send()
}
public extension ICombineProtocol{
    func register(_ delegate:ICombineDelegate){
        if delegates.contains(where: { item in
            item === delegate
        }){
            return
        }
        delegates.append(delegate)
    }
    
    func unRegister(_ delegate:ICombineDelegate){
        delegates.removeAll { item in
            item === delegate
        }
    }
    
    func send(){
        delegates.forEach { delegate in
            delegate.valueDidChange()
        }
    }
}
