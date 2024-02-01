//
//  AddButton.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 29.01.2024.
//

import Foundation
import UIKit

class AddButton : UIButton {
    
    init(title: String) {
        self.title.text = title
        super.init(frame: .zero)
        
        configureView()
        addViews()
        layoutConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title : UILabel = {
        let title = UILabel()
        title.font = UIFont.R.nunitoSans(size: 16, weight: .bold)
        title.textColor = R.Colors.black
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var image : UIImageView = {
        let image = UIImageView()
        image.image = R.Images.Buttons.plusIcon
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
}

extension AddButton {
    
    func configureView() {
        backgroundColor = R.Colors.active.withAlphaComponent(0.8)
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    func addViews() {
        addSubview(title)
        addSubview(image)
    }
    
    func layoutConstaints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 15),
            image.widthAnchor.constraint(equalToConstant: 15),
            
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            title.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
}
