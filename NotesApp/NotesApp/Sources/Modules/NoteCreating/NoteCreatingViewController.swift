//
//  NoteEditingViewController.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 29.01.2024.
//

import Foundation
import UIKit

final class NoteCreatingViewController : BaseViewController {
    
    //MARK: - Properites
    
    private(set) var viewModel : NoteCreatingViewModel
    
    public var completionHandler : ((NoteEntity)->())?
    
    //MARK: - Init
    
    init(viewModel: NoteCreatingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textField.resignFirstResponder()
    }

    //MARK: - UI Objects
    
    private let titleLabel = UILabel()
    
    private lazy var saveButton = AddButton(title: R.Strings.Buttons.save)
    
    private var textField : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.R.nunitoSans(size: 16, weight: .medium)
        textView.backgroundColor = R.Colors.background
        textView.textColor = R.Colors.black
        textView.tintColor = R.Colors.active
        return textView
    }()
    
    //MARK: - Overriding parent method
    
    override func navBarRightItemHandler() {
        guard let text = textField.text, !text.isEmpty else { return }
        
        let title = textField.getFirstLine()
        let restOfText = textField.getTextWithoutTitle()
        let note : Note
        var noteEntity : NoteEntity = NoteEntity()
        
        let context = CoreDataManager.shared.mainContext
        let numLines = textField.contentSize.height / textField.font!.lineHeight;
        if numLines < 2 {
            
            note = Note(title: title, text: "", date: Date.now, noteType: .daily, isFavorite: viewModel.note?.isFavorite ?? false)
            noteEntity = note.mapToEntityInContext(context)
            print(numLines)
        } else {
            note = Note(title: title, text: restOfText, date: Date.now, noteType: .daily, isFavorite: viewModel.note?.isFavorite ?? false)
            noteEntity = note.mapToEntityInContext(context)
            print(numLines)
        }
        completionHandler?(noteEntity)
    }
}

extension NoteCreatingViewController {
    
    override func configureView() {
        super.configureView()
        textField.delegate = self
        
        titleLabel.text = R.Strings.Titles.creatingNote
        titleLabel.font = UIFont.R.nunitoSans(size: 20, weight: .bold)
        titleLabel.textColor = R.Colors.active
        
        saveButton.image.image = R.Images.Buttons.saveIcon
        saveButton.addTarget(self, action: #selector(navBarRightItemHandler), for: .touchUpInside)
        saveButton.animateTouch(saveButton)
    }
    
    override func addSubviews() {
        view.addSubview(textField)
        view.addSubview(titleLabel)
        view.addSubview(saveButton)
        addNavBarItem(at: .right(type: .button), title: R.Strings.Buttons.save)
    }
    
    override func layoutConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 16),
            textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)

        ])
        
    }
    
}


extension NoteCreatingViewController : UITextViewDelegate {

}
