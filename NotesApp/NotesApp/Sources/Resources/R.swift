//
//  R.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import Foundation
import UIKit

enum R {
    
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
    
    enum Images {
        
        enum Onboarding {
            static func image(for page: OnboardingControllers) -> UIImage? {
                switch page {
                case .first:
                    UIImage(named: "Onboarding1")
                case .second:
                    UIImage(named: "Onboarding2")
                case .third:
                    UIImage(named: "profile_tab")
                }
            }
        }
        
        enum Buttons {
            static var plusIcon = UIImage(named: "plusIcon")
        }
    }
    
    enum Strings {
        
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
                        "Управляйтесь с вашими запискам с легкостью"
                    case .second:
                        "Упорядочивайте свои мысли"
                    case .third:
                        "Начните"
                    }
                }
            }
            enum Subtitles {
                static func subtitle(for page: OnboardingControllers) -> String? {
                    switch page {
                    case .first:
                        "Удобнейший способ управления и кастомизации ваших записок"
                    case .second:
                        "Делай заметки, трекайте даты и добавляйте фотографии"
                    case .third:
                        "И ощутите все удобства приложения"
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
