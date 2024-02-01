//
//  Core.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 31.01.2024.
//

import Foundation

final class Core {
    
    static var shared = Core()
    
    private init() {}
    
    //MARK: - User Defaults for saving user's first entry
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: R.Strings.Keys.isNewUser)
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.setValue(true, forKey: R.Strings.Keys.isNewUser)
    }
    
}
