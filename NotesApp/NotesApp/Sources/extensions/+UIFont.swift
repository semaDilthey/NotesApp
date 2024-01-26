//
//  +UIFont.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import UIKit

extension UIFont {
    
    enum R {
        
        enum NunitoSans: Int {
                case thin = 400
                case medium = 500
                case bold = 600
                
                var nameFont: String {
                    switch self {
                    case .thin:
                        return "Nunito Sans 10pt Light"
                    case .medium:
                        return "Nunito Sans 10pt Regular"
                    case .bold:
                        return "Nunito Sans 10pt SemiBold"
                    }
                }
            }
            
            static func nunitoSans(size fontSize: CGFloat, weight fontWeight: NunitoSans) -> UIFont? {
                UIFont(name: fontWeight.nameFont, size: fontSize)
            }
        
    }
}
