//
//  NotesViewModel.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import Foundation
import UIKit

class NotesViewModel {
    
    var dataStorage : DataStorage
    
    init(dataStorage: DataStorage) {
        self.dataStorage = dataStorage
    }
    
    func fetchNotes() {
        self.dataStorage.fetchNotes { notes in
            switch notes {
            case .success(let success):
                if !success.isEmpty {
                    self.dataStorage.notes = success
                } else {
                    if (UIApplication.shared.delegate as! AppDelegate).isNewUser() {
                        let note = Note(title: "Title 0", text: "Text 0", date: Date.now, pictures: nil, noteType: .toDo, index: 0)
                        self.saveNote(note)
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

    func saveNote(_ note: Note) {
        dataStorage.saveNote(note)
    }
    
    func updateNote(_ note: Note, at indexPath: IndexPath) {
        dataStorage.updateNote(note, at: indexPath.row)
        dataStorage.deleteNote(at: indexPath.row)

//        print(indexPath.row)
//        dataStorage.saveNote(note)
//        print(dataStorage.notes)

    }
    
    func getNote(at indexPath: IndexPath) -> Note? {
        guard indexPath.row < getNotesCount() else {  return nil }
        return dataStorage.notes[indexPath.row]
    }
    
    func getNotesCount() -> Int {
        return dataStorage.notes.count
    }
        
}
