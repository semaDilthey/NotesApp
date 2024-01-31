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
            dateFormatter.dateFormat = "dd MMM yyyy"
            dateFormatter.locale = Locale(identifier: "ru_RU") // Устанавливаем локаль для отображения месяца на русском языке
            return dateFormatter.string(from: self)
        }
    
}
