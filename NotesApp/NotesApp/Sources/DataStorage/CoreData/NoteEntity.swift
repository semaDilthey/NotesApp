//
//  NoteEntity+CoreDataProperties.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 30.01.2024.
//
//

import Foundation
import CoreData

@objc(NoteEntity)
public class NoteEntity: NSManagedObject {}

extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var date: Date?
    @NSManaged public var noteType: Int16
    @NSManaged public var isFavorite: Bool

}

extension NoteEntity : Identifiable {}
