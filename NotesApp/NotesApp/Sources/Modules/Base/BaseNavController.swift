//
//  BaseNavController.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import Foundation
import UIKit

class BaseNavController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
           
       let navBarAppearance = UINavigationBarAppearance()
       navBarAppearance.backgroundColor = R.Colors.background
       navBarAppearance.titleTextAttributes = [.foregroundColor : R.Colors.active,
                                               .font : UIFont.R.nunitoSans(size: 17, weight: .bold)]
       navBarAppearance.shadowColor = R.Colors.background
     
       navigationBar.standardAppearance = navBarAppearance
       navigationBar.scrollEdgeAppearance = navBarAppearance
       navigationBar.isTranslucent = false

       }

}

