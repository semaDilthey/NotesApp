//
//  Note.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import UIKit
import CoreData

enum NoteType: Int, CaseIterable {
    case toDo
    case work
    case daily
    case other
}

struct Note {
    var title: String
    var text: String
    var date: Date
    var pictures: [UIImage]?
    var noteType: NoteType
    var isFavorite: Bool
    
    var fullText : String {
        title + "\n" + text
    }
    
    init(title: String, text: String, date: Date, pictures: [UIImage]? = nil, noteType: NoteType, isFavorite: Bool) {
        self.title = title
        self.text = text
        self.date = date
        self.pictures = pictures
        self.noteType = noteType
        self.isFavorite = isFavorite
    }
}

extension Note : EntityModelMapProtocol {
    
    typealias EntityType = NoteEntity

    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let note = NoteEntity(context: context)
        note.title = self.title
        note.text = self.text
        note.date = self.date
        note.noteType = Int16(self.noteType.rawValue)
        note.isFavorite = self.isFavorite
        
        return note
    }
    
    static func mapFromEntity(_ entity: EntityType) -> Note {
        let note = Note(
            title: entity.title ?? "No title",
            text: entity.text ?? "No text",
            date: entity.date ?? Date.now,
            noteType: NoteType(rawValue: Int(entity.noteType)) ?? .toDo,
            isFavorite: entity.isFavorite
        )
        return note
    }
}

