//
//  NotesCell.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import Foundation
import UIKit

class NotesCell: BaseCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with note: Note) {
        titleLabel.text = note.title
        textLabel.text = note.text
        dateLabel.text = note.date.description
    }
    
    private var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.R.nunitoSans(size: 16, weight: .bold)
        titleLabel.textColor = R.Colors.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakStrategy = .standard
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "Это будет заголовок для твоей пизды"
        return titleLabel
    }()
    
    private var textLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.R.nunitoSans(size: 14, weight: .thin)
        textLabel.textColor = R.Colors.black
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 3
        textLabel.lineBreakStrategy = .standard
        textLabel.text = "Тут \n gff \n ff \n fd"
        textLabel.clipsToBounds = true
        return textLabel
    }()
    
    private var dateLabel : UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.R.nunitoSans(size: 8, weight: .medium)
        dateLabel.textColor = R.Colors.black
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = Date.now.formattedDateString()
        return dateLabel
    }()
    
}

extension NotesCell {
    
    override func configureView() {
        super.configureView()
    }
    
    override func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textLabel)
        contentView.addSubview(dateLabel)
    }
    
    override func layoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
