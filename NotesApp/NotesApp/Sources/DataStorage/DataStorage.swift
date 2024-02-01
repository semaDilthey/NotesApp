//
//  DataStorage.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import Foundation
import UIKit
import CoreData

protocol Persistable {
    var notes : [NoteEntity]? { get set }
    var notesUpdated : (()->())? { get set }
    mutating func saveNote(_ note: NoteEntity)
    mutating func fetchNotes(completion: @escaping (Result<[NoteEntity], Error>)-> Void)
    mutating func updateNote(_ note: NoteEntity, at index: Int)
    mutating func deleteNote(at index: Int)
    
    mutating func addToFavorites(_ note: NoteEntity, at index: Int, isFavorite: Bool)
}

struct DataStorage : Persistable {
    
    var storageManager : CoreDataManager
    
    init(storageManager: CoreDataManager = CoreDataManager.shared) {
        self.storageManager = storageManager
    }
    
    var notes : [NoteEntity]? {
        didSet {
            notesUpdated?()
        }
    }
    
    var notesUpdated : (()->())?
    
    mutating func saveNote(_ note: NoteEntity) {
        guard let noteEntityDescription = NSEntityDescription.entity(forEntityName: R.Strings.Entity.noteEntity,
                                                                           in: storageManager.mainContext) else { return }
        var noteEntity = NoteEntity(entity: noteEntityDescription, insertInto: storageManager.mainContext)
        do {
            noteEntity = note
            try storageManager.mainContext.save()
            notes?.append(noteEntity)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    mutating func fetchNotes(completion: @escaping (Result<[NoteEntity], Error>)-> Void) {
        
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        let sortDescriptorByDate = NSSortDescriptor(key: "date", ascending: true)
        let sortDescriptorByIsFav = NSSortDescriptor(key: "isFavorite", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptorByIsFav, sortDescriptorByDate]
        
        do {
            let noteEntities = try storageManager.mainContext.fetch(fetchRequest)
            let filteredEntites = noteEntities.filter { $0.text != nil && $0.title != nil}
            
            self.notes = filteredEntites
            completion(.success(filteredEntites))
        } catch {
            completion(.failure(error))
        }
    }
    
    
    mutating func updateNote(_ note: NoteEntity, at index: Int) {
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
//        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
//        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            let noteEntities = try storageManager.mainContext.fetch(fetchRequest)
            var filteredEntity = noteEntities.filter { $0.date == note.date }.first
            
//            notes?.insert(note, at: index+1)
//            notes?.remove(at: index)
            filteredEntity = note

            try storageManager.mainContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    mutating func addToFavorites(_ note: NoteEntity, at index: Int, isFavorite: Bool) {
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()

        do {
            let noteEntities = try storageManager.mainContext.fetch(fetchRequest)
            var filteredEntity = noteEntities.filter { $0.date == note.date }.first
            
            filteredEntity?.isFavorite = isFavorite
            notes?[index].isFavorite = note.isFavorite
            try storageManager.mainContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    mutating func deleteNote(at index: Int) {
    
        do {
            let noteToDeletion = notes?[index]
            guard let noteToDeletion else { return }
            storageManager.mainContext.delete(noteToDeletion)
            if index > 0 {
                notes?.remove(at: index)
            } else {
                notes?.remove(at: 0)
            }
        }
        storageManager.saveContext()
    }
}

extension DataStorage {
    
    private func findNoteEntity(withIndex index: Int, in context: NSManagedObjectContext) -> NoteEntity? {
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "index == %d", index)

        do {
            let result = try context.fetch(fetchRequest)
            return result.first
        } catch {
            print("Error finding note entity: \(error)")
            return nil
        }
    }
    
}

