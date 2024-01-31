//
//  NoteEditingViewModel.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 29.01.2024.
//

import Foundation

final class NoteCreatingViewModel {
    
    var note : Note?
    var index: Int
    
    init(note: Note? = nil, index: Int) {
        self.note = note
        self.index = index
    }
    
}
