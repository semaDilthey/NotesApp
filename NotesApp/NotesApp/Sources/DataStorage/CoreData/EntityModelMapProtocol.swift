//
//  EntityModelMapProtocol.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 30.01.2024.
//

import Foundation
import CoreData

protocol EntityModelMapProtocol {
    typealias EntityType = NoteEntity
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType
    static func mapFromEntity(_ entity: EntityType) -> Note
}
