//
//  ICloudKit.swift
//  iApple
//
//  Created by mac on 2023/7/6.
//

import Foundation
import CloudKit

public extension CloudKitCoreDataManage{
    // 创建订阅
    func registSubscription(){
        ["RecordClassify","RecordField"].forEach { item in
            registPublicRecordTypeSubscription(recordType: item)
        }
        
        registPublicDatabaseSubscription()
        registPrivateDatabaseSubscription()
    }
    // 创建公共数据订阅
    func registPublicDatabaseSubscription(){
   
        let subscription = CKDatabaseSubscription(subscriptionID: "PubliceSubscriptionID")

        // 配置订阅的通知信息
        let notificationInfo = CKSubscription.NotificationInfo()
        notificationInfo.shouldSendContentAvailable = true // 设置为 true，以便在数据更改时接收到通知
        subscription.notificationInfo = notificationInfo

        // 将订阅添加到你的 CloudKit 数据库
        let database = CKContainer.default().publicCloudDatabase
        database.save(subscription) { (subscription, error) in
            if let error = error {
                print("订阅保存失败：\(error.localizedDescription)")
            } else {
                print("订阅保存成功")
            }
        }
    }
    // 创建公共数据订阅
    func registPublicRecordTypeSubscription(recordType:String){
        // 创建一个订阅
        let subscription = CKQuerySubscription.init(recordType: recordType, predicate: .init(value: true))

        // 配置订阅的通知信息
        let notificationInfo = CKQuerySubscription.NotificationInfo()
        notificationInfo.shouldSendContentAvailable = true // 设置为 true，以便在数据更改时接收到通知
        notificationInfo.shouldBadge = true
        subscription.notificationInfo = notificationInfo

        // 将订阅添加到你的 CloudKit 数据库
        let database = CKContainer.default().publicCloudDatabase
        database.save(subscription) { (subscription, error) in
            if let error = error {
                print("订阅保存失败：\(error.localizedDescription)")
            } else {
                print("订阅保存成功")
            }
        }
    }
    // 创建私有数据订阅
    func registPrivateDatabaseSubscription(){
   
        let subscription = CKDatabaseSubscription(subscriptionID: "PrivateSubscriptionID")

        // 配置订阅的通知信息
        let notificationInfo = CKSubscription.NotificationInfo()
        notificationInfo.shouldSendContentAvailable = true // 设置为 true，以便在数据更改时接收到通知
        subscription.notificationInfo = notificationInfo

        // 将订阅添加到你的 CloudKit 数据库
        let database = CKContainer.default().privateCloudDatabase
        database.save(subscription) { (subscription, error) in
            if let error = error {
                print("订阅保存失败：\(error.localizedDescription)")
            } else {
                print("订阅保存成功")
            }
        }
    }
}

public extension CloudKitCoreDataManage{
    
    // 处理订阅事件
    func handleCKRecordChanges( notification:CKNotification)async throws{
        if notification.notificationType == .query {
            // 收到了查询通知
            let queryNotification = notification as! CKQueryNotification
            let recordID = queryNotification.recordID
            let queryNotificationReason = queryNotification.queryNotificationReason
           
            // 根据通知的原因执行相应的操作
            if queryNotificationReason == .recordCreated {
                // 记录被创建
                // 处理创建记录的操作
            } else if queryNotificationReason == .recordUpdated {
                // 记录被更新
                // 处理更新记录的操作
            } else if queryNotificationReason == .recordDeleted {
                // 记录被删除
                // 处理删除记录的操作
            }
        }
    }
}
