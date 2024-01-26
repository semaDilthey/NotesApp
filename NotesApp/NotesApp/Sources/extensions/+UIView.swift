//
//  +UIView.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import UIKit

extension UIView {
    
    func animateTouch(_ button: UIButton) {
        button.addTarget(self, action: #selector(handleIn), for: [.touchDown, .touchDragInside])
        
        button.addTarget(self, action: #selector(handleOut), for: [.touchCancel, .touchDragOutside, .touchUpOutside, .touchUpInside, .touchDragExit])
       
    }
    
    @objc func handleIn() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 0.55
        }
    }
    
    @objc func handleOut() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 1
        }
    }
    
}
