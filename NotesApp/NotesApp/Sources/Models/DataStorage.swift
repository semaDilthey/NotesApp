//
//  DataStorage.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import Foundation
import UIKit
import CoreData

//struct DataStorage {
//    
//    var storageManager : CoreDataManager
//    
//    init(storageManager: CoreDataManager = CoreDataManager.shared) {
//        self.storageManager = storageManager
//    }
//    
//    var notes : [Note] = [Note(title: "title", text: "Lorem ipsum", date: .now, noteType: .daily, index: 0)]
//    
//    func getNote(at index: Int) {
//        
//    }
//    
//    func getNotes() -> [Note]? {
//        return nil
//    }
//    
//    mutating func saveNote(_ note: Note) {
//        let context = storageManager.mainContext
//        let noteEntity = NoteEntity(context: context)
//
//        noteEntity.title = note.title
//        noteEntity.text = note.text
//        noteEntity.date = note.date
//        noteEntity.noteType = Int16(note.noteType.rawValue)
//        noteEntity.index = Int16(note.index)
//
////        if let pictures = note.pictures {
////            let pictureDataArray = pictures.map { UIImagePNGRepresentation($0) }
////            noteEntity.pictures = pictureDataArray as [NSData]
////        }
//        storageManager.saveContext()
//        print("Сохранение отработало")
//    }
//
//    mutating func updateNote(_ note: Note, at index: Int) {
//        let context = storageManager.mainContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: R.Strings.Entity.noteEntity)
//        do {
//            guard let notes = try? context.fetch(fetchRequest) as [Note]? , var newNote = notes.first(where: { $0.index == index }) else { return }
//                newNote = note
//            print("newNote \(newNote)")
//        }
//        
////        guard var noteEntity = findNoteEntity(withIndex: index, in: context) else {
////            print("Note with index \(index) not found.")
////            return
////        }
////        let updatableEntity = note.mapToEntityInContext(context)
//        // Обновляем текст в найденной записи
////        noteEntity = updatableEntity
//        storageManager.saveContext()
//        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
//        appDelegate.saveContext()
//    }
//    
//    func fetchNotes(completion: @escaping (Result<[Note], Error>)-> Void) {
//        let context = storageManager.mainContext
//        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
//        
//        do {
//            let noteEntities = try context.fetch(fetchRequest)
//            let notes = noteEntities.map { entity in
//                return Note.mapFromEntity(entity)
//            }
//            completion(.success(notes))
//        } catch {
//            completion(.failure(error))
//        }
//    }
//    
//    mutating func createNote(at index: Int) {
//        
//    }
//    
//    mutating func deleteNote(at index: Int) {
//        
//    }
//    
//    private func findNoteEntity(withIndex index: Int, in context: NSManagedObjectContext) -> NoteEntity? {
//        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "index == %d", index)
//
//        do {
//            let result = try context.fetch(fetchRequest)
//            return result.first
//        } catch {
//            print("Error finding note entity: \(error)")
//            return nil
//        }
//    }
//}
//MARK: - 2 но работающий варик

//struct DataStorage {
//    
//    var storageManager : CoreDataManager
//    
//    init(storageManager: CoreDataManager = CoreDataManager.shared) {
//        self.storageManager = storageManager
//    }
//    
//    var notes : [Note] = []
//    
//    mutating func saveNote(_ note: Note) {
//        guard let noteEntityDescription = NSEntityDescription.entity(forEntityName: R.Strings.Entity.noteEntity,
//                                                                     in: storageManager.mainContext) else { return }
//
//        let noteEntity = NoteEntity(entity: noteEntityDescription, insertInto: storageManager.mainContext)
//        noteEntity.title = note.title
//        noteEntity.text = note.text
//        noteEntity.date = note.date
//        noteEntity.noteType = Int16(note.noteType.rawValue)
//        noteEntity.index = Int16(note.index)
//        
//        storageManager.saveContext()
//        notes.append(note)
//        print("Сохранение отработало")
//    }
//
//    func fetchNotes(completion: @escaping (Result<[Note], Error>)-> Void) {
//        let context = storageManager.mainContext
//        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
//        
//        do {
//            let noteEntities = try context.fetch(fetchRequest)
//            let notes = noteEntities.map { entity in
//                return Note.mapFromEntity(entity)
//            }
//            completion(.success(notes))
//        } catch {
//            completion(.failure(error))
//        }
//    }
//    
//    mutating func updateNote(_ note: Note, at index: Int) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: R.Strings.Entity.noteEntity)
//        do {
//            guard let notes = try? storageManager.mainContext.fetch(fetchRequest) as [NoteEntity]? , var newNote = notes.first(where: { $0.index == index }) else { return }
//            newNote = note.mapToEntityInContext(storageManager.mainContext)
//            print("newNote \(newNote)")
//        }
//        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
//        notes.insert(note, at: 0)
//        print("Notes after updating \(notes)")
//        appDelegate.saveContext()
//    }
//    
//    mutating func createNote(at index: Int) {
//        
//    }
//    
//    mutating func deleteNote(at index: Int) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: R.Strings.Entity.noteEntity)
//        do {
//            guard let notes = try? storageManager.mainContext.fetch(fetchRequest) as? [NoteEntity]? ,
//                  let noteToDelete = notes?.first(where: { $0.index == index }) else { return }
//            storageManager.mainContext.delete(noteToDelete)
//            print("Deleted note is \(noteToDelete)")
//        }
//        notes.remove(at: index)
//        print("Notes after deleting \(notes)")
//        storageManager.saveContext()
//    }
//    
//    private func findNoteEntity(withIndex index: Int, in context: NSManagedObjectContext) -> NoteEntity? {
//        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "index == %d", index)
//
//        do {
//            let result = try context.fetch(fetchRequest)
//            return result.first
//        } catch {
//            print("Error finding note entity: \(error)")
//            return nil
//        }
//    }
//}
//

struct DataStorage {
    
    var storageManager : CoreDataManager
    
    init(storageManager: CoreDataManager = CoreDataManager.shared) {
        self.storageManager = storageManager
    }
    
    var notes : [NoteEntity] = []
    
    mutating func saveNote(_ note: Note) {
        guard let noteEntityDescription = NSEntityDescription.entity(forEntityName: R.Strings.Entity.noteEntity,
                                                                     in: storageManager.mainContext) else {
            return print("Unable to save note")
        }

        let noteEntity = NoteEntity(entity: noteEntityDescription, insertInto: storageManager.mainContext)
        noteEntity.title = note.title
        noteEntity.text = note.text
        noteEntity.date = note.date
        noteEntity.noteType = Int16(note.noteType.rawValue)
        noteEntity.index = Int16(note.index)
   
        storageManager.saveContext()
        notes.append(noteEntity)
        print("Сохранение отработало")
    }

    mutating func fetchNotes(completion: @escaping (Result<[Note], Error>)-> Void) {
        let context = storageManager.mainContext
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        
        do {
            let noteEntities = try context.fetch(fetchRequest)
            self.notes = noteEntities
            
            let notes = noteEntities.map { entity in
                return Note.mapFromEntity(entity)
            }
            completion(.success(notes))
        } catch {
            completion(.failure(error))
        }
    }
    
    mutating func updateNote(_ note: Note, at index: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: R.Strings.Entity.noteEntity)
        let noteEntity = note.mapToEntityInContext(storageManager.mainContext)
        do {
            guard let notes = try? storageManager.mainContext.fetch(fetchRequest) as [NoteEntity]? , var newNote = notes.first(where: { $0.index == index }) else { return }
            newNote = note.mapToEntityInContext(storageManager.mainContext)
            print("newNote \(newNote)")
        }
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        notes.insert(noteEntity, at: 0)
        print("Notes after updating \(notes)")
        appDelegate.saveContext()
    }
    
    mutating func createNote(at index: Int) {
        
    }
    
    mutating func deleteNote(at index: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: R.Strings.Entity.noteEntity)
        do {
            guard let notes = try? storageManager.mainContext.fetch(fetchRequest) as? [NoteEntity]? ,
                  let noteToDelete = notes?.first(where: { $0.index == index }) else { return }
            storageManager.mainContext.delete(noteToDelete)
            print("Deleted note is \(noteToDelete)")
        }
        notes.remove(at: index)
        print("Notes after deleting \(notes)")
        storageManager.saveContext()
    }
    
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

