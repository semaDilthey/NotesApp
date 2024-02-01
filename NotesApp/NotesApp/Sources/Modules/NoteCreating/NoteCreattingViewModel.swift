//
//  NoteEditingViewModel.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 29.01.2024.
//

import Foundation

final class NoteCreatingViewModel {
    
    var note : NoteEntity?
    var index: Int
    
    init(note: NoteEntity? = nil, index: Int) {
        self.note = note
        self.index = index
    }
    
}
