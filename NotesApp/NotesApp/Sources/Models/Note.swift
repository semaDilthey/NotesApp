//
//  Note.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import UIKit

enum NoteType: CaseIterable {
    case toDo
    case work
    case daily
    case other
}

struct Note {
    var text: String
    var date: Date
    var pictures: [UIImage]?
    var noteType: NoteType
    
    init(text: String, date: Date, pictures: [UIImage]? = nil, noteType: NoteType) {
        self.text = text
        self.date = date
        self.pictures = pictures
        self.noteType = noteType
    }
}

