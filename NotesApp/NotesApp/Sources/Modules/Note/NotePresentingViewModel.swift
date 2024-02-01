//
//  NoteEditingViewModel.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 29.01.2024.
//

import Foundation

final class NotePresentingViewModel {
    
    var updateData: (()->())?
    var index: Int
    
    var note : NoteEntity {
        didSet {
            updateData?()
        }
    }
    
    init(note: NoteEntity, index: Int) {
        self.note = note
        self.index = index
    }
    
}
