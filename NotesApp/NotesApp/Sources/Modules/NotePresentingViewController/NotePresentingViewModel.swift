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
    
    var note : Note {
        didSet {
            updateData?()
        }
    }
    
    init(note: Note, index: Int) {
        self.note = note
        self.index = index
    }
    
}
