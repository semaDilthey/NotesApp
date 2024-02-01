//
//  +Date.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 29.01.2024.
//

import Foundation

extension Date {
    
    func formattedDateString() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
            dateFormatter.locale = Locale(identifier: "ru_RU") 
            return dateFormatter.string(from: self)
        }
    
}
