//
//  NotesViewModel.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import Foundation

class NotesViewModel {
    
    var dataStorage : DataStorage
    
    init(dataStorage: DataStorage) {
        self.dataStorage = dataStorage
    }
    
    func getNotes() -> [Note] {
        return []
    }
    
    func getNotesCount() -> Int {
        return 30
    }
    
}
