//
//  NoteEditingViewController.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 29.01.2024.
//

import Foundation
import UIKit

final class NoteCreatingViewController : BaseViewController {
    
    private(set) var viewModel : NoteCreatingViewModel
    
    public var completionHandler : ((Note)->())?
    
    init(viewModel: NoteCreatingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textField.resignFirstResponder()
        navBarRightItemHandler()
    }
    
    private var textField : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.R.nunitoSans(size: 16, weight: .medium)
        textView.backgroundColor = R.Colors.background
        textView.textColor = R.Colors.black
        textView.tintColor = R.Colors.active
        return textView
    }()
    
    override func navBarRightItemHandler() {
        guard let text = textField.text, !text.isEmpty else { return }
        
        let title = textField.getFirstLine()
        let restOfText = textField.getTextWithoutTitle()
        let note : Note
        let numLines = textField.contentSize.height / textField.font!.lineHeight;
        if numLines < 2 {
            note = Note(title: title, text: "", date: Date.now, noteType: .daily, index: viewModel.index)
            print(numLines)
        } else {
            note = Note(title: title, text: restOfText, date: Date.now, noteType: .daily, index: viewModel.index)
            print(numLines)
        }
            completionHandler?(note)
    }
}

extension NoteCreatingViewController {
    
    override func configureView() {
        super.configureView()
        textField.delegate = self
    }
    
    override func addSubviews() {
        view.addSubview(textField)
        addNavBarItem(at: .right(type: .button), title: "Сохранить")
    }
    
    override func layoutConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)

        ])
        
    }
    
}


extension NoteCreatingViewController : UITextViewDelegate {

}
