//
//  StorageManager.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 30.01.2024.
//

import Foundation
import UIKit
import CoreData

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
    case couldNotDeleteObject
    case error(Error)
    
    var localizedDescription: String {
        switch self {
        case .managedObjectContextNotFound:
            "Не удалось найти контекст"
        case .couldNotSaveObject:
            "Не удалось сохранить объект"
        case .objectNotFound:
            "Объект не найден"
        case .couldNotDeleteObject:
            "Не удалось удалить объект"
        case .error(let error):
            error.localizedDescription
        }
    }
}


public final class CoreDataManager : NSObject {
    
    public static let shared = CoreDataManager()
    
    private override init() { }
    
    private var appDelegate : AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    var mainContext: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    var persistentContainer : NSPersistentContainer {
        appDelegate.persistentContainer
    }
    
    func saveContext() {
        appDelegate.saveContext()
    }
    
    func resetAllCoreData() {
        let entityNames = self.persistentContainer.managedObjectModel.entities.map({ $0.name!})
        entityNames.forEach { [weak self] entityName in
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try self?.mainContext.execute(deleteRequest)
                try self?.mainContext.save()
            } catch {
                // error
            }
        }
    }
}
