//
//  BaseCell.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import UIKit

class BaseCell : UICollectionViewCell {
        
    static var identifier = "BaseCell"

    override var isSelected: Bool {
        didSet {
            isSelected ? contentView.backgroundColor = .black.withAlphaComponent(0.1) : configureView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addSubviews()
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
}

@objc extension BaseCell {
    
    func configureView() {
        contentView.backgroundColor = R.Colors.setRandomColor()
        #warning("Возмжожно всем запискам сделать желтый/ розовый цвет")
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    func layoutConstraints() {}
    func addSubviews() {}
    
    func navBarLeftItemHandler() {
        print("Left selector was tapped")
    }
    
    func navBarRightItemHandler() {
        print("Rigth selector was tapped")
    }
}


