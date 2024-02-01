//
//  R.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import Foundation
import UIKit

enum R {
    
    //MARK: - Colors
    
    enum Colors : CaseIterable {
        
        static var background = UIColor(hexString: "#F2F2F6")
        static var active = UIColor(hexString: "#FD3A69")
        static var inActive = UIColor(hexString: "#FFFFFF")
        static var black = UIColor(hexString: "#1C2121")
        static var white = UIColor(hexString: "#FFFFFF")
        static var grey = UIColor(hexString: "#CECBD3")
        
        static func setRandomColor() -> UIColor? {
            let colors : [UIColor]? = [.red, .blue, .green, .yellow, .orange,]
            guard let colors else { return nil }
            return colors.randomElement()?.withAlphaComponent(0.2)
        }
    }
    
    //MARK: - Images
    
    enum Images {
        
        enum Onboarding {
            static func image(for page: OnboardingControllers) -> UIImage? {
                switch page {
                case .first:
                    UIImage(named: "Onboarding1")
                case .second:
                    UIImage(named: "Onboarding2")
                case .third:
                    UIImage(named: "Onboarding3")
                }
            }
        }
        
        enum Buttons {
            static var plusIcon = UIImage(named: "plusIcon")
            static var saveIcon = UIImage(named: "diskette")
            static var notFavorite = UIImage(named: "!isFavorite")
            static var isFavorite = UIImage(named: "isFavorite")
        }
    }
    
    //MARK: -  Strings
    
    enum Strings {
        
        enum Titles {
            
            static var creatingNote = "Создание заметки"
        }
        
        enum Buttons {
            static var back = "Назад"
            static var notes = "Заметки"
            static var save = "Сохранить"
            static var add = "Добавить"
        }
        
        enum Labels {
            static var myNotes = "Мои записки"
            static var noNotes = "Нет записок"
        }
        
        enum Keys {
            static var isNewUser = "isNewUser"
        }
        
        enum Entity {
            static var noteEntity = "NoteEntity"
        }
        
        enum Onboarding {
            
            enum Titles {
                static func title(for page: OnboardingControllers) -> String? {
                    switch page {
                    case .first:
                        "Добавление заметки в изабранное"
                    case .second:
                        "Для удаления просто свайпните вправо"
                    case .third:
                        "Начните"
                    }
                }
                
            }
            enum Subtitles {
                static func subtitle(for page: OnboardingControllers) -> String? {
                    switch page {
                    case .first:
                        "Просто нажмите на нужную кнопку и заметка всегда будет ждать вас вверху!"
                    case .second:
                        "Но будьте осторожны, восстановить не получится"
                    case .third:
                        "И получится удовольствие от приложения!"
                    }
                }
            }
            
            enum Buttons {
                static func buttonText(for page: OnboardingControllers) -> String? {
                    switch page {
                    case .first:
                        "Далее"
                    case .second:
                        "Далее"
                    case .third:
                        "Начать"
                    }
                }
            }
          
        }
    }
    
    //MARK: - Sizes
    
    enum Sizes {
        static private var screenSize = UIScreen.main.bounds
        
        static var screenWidth : CGFloat {
            screenSize.width
        }
        
        static var screenHeight : CGFloat {
            screenSize.height
        }
        
    }

    
}
