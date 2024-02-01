//
//  NotesViewModel.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import Foundation
import UIKit

class NotesViewModel {
    
    var dataStorage : Persistable
    
    init(dataStorage: Persistable) {
        self.dataStorage = dataStorage
    }
    
    //MARK: - CallBack after notes collection is being updated
    func notesCallback(completion: @escaping(()->())) {
        dataStorage.notesUpdated = {
            completion()
        }
    }
    
    //MARK: - CRUD
    
    func saveNote(_ note: NoteEntity) {
        dataStorage.saveNote(note)
    }
    
    func fetchNotes(completion: @escaping(()->())) {
        self.dataStorage.fetchNotes { notes in
            switch notes {
            case .success(let success):
                if !success.isEmpty {
                    DispatchQueue.main.async {
                        self.dataStorage.notes = success
                    }
                } else {
                    if Core.shared.isNewUser() {
                        let note = Note(title: "Its your first note", text: "Its your first text", date: Date.now, pictures: nil, noteType: .toDo, isFavorite: false)
                        DispatchQueue.main.async {
                            let noteEntity = note.mapToEntityInContext(CoreDataManager.shared.mainContext)
                            self.saveNote(noteEntity)
                        }
                        print("Failure")
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func updateNote(_ note: NoteEntity, at indexPath: IndexPath) {
        dataStorage.updateNote(note, at: indexPath.row)
    }
    
    func deleteNote(at index: Int) {
        dataStorage.deleteNote(at: index)
    }
    
    func addToFav(_ note: NoteEntity, at indexPath: IndexPath, isFav: Bool) {
        dataStorage.addToFavorites(note, at: indexPath.row, isFavorite: isFav)
    }
    
    //MARK: - Coordinator
    // Надо бы в координатор все это загонять но не успеваю
    func getEditingController(at index: Int) -> NotePresentingViewController? {
        guard let note = dataStorage.notes?[index] else { return nil }
        let vm = NotePresentingViewModel(note: note, index: index)
        let vc = NotePresentingViewController(viewModel: vm)
        vc.configure(with: note)
        return vc
    }
    
    func getCreatingController() -> NoteCreatingViewController {
        let index = getNotesCount()
        let vm = NoteCreatingViewModel(index: index)
        let vc = NoteCreatingViewController(viewModel: vm)
        return vc
    }
    
    //MARK: - Methods for tableView
    func getNote(at indexPath: IndexPath) -> NoteEntity? {
        guard indexPath.row < getNotesCount() else {  return nil }
        return dataStorage.notes?[indexPath.row]
    }
    
    func getNotesCount() -> Int {
        guard let notesCountr = dataStorage.notes?.count else { return 0 }
        return notesCountr
    }
        
}
