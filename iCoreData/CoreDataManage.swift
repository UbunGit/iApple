//
//  CoreDataManage.swift
//  iHealth
//
//  Created by mac on 2023/5/20.
//

import Foundation
import CloudKit
import CoreData

public class CoreDataManage{
    
    let modenName:String
    let identifier:String
    
    public init(modenName: String, identifier: String) {
        self.modenName = modenName
        self.identifier = identifier
    }
    
    public lazy var publicContainer: NSPersistentCloudKitContainer = {
        
        let container = NSPersistentCloudKitContainer(name: modenName)
        
        let publicURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("public.sqlite")
        let cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: identifier)
        let description = NSPersistentStoreDescription(url: publicURL)
        description.configuration = "public"
        description.cloudKitContainerOptions = cloudKitContainerOptions
        description.cloudKitContainerOptions?.databaseScope = .public
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    public lazy var privateContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: modenName)
        let privateURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("private.sqlite")
        
        let cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: identifier)
        
        let description = NSPersistentStoreDescription(url: privateURL)
        description.configuration = "private"
        description.cloudKitContainerOptions = cloudKitContainerOptions
        description.cloudKitContainerOptions?.databaseScope = .private
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
}
