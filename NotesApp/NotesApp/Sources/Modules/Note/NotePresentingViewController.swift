
//  NoteEditingViewController.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 29.01.2024.
//

import Foundation
import UIKit

final class NotePresentingViewController : BaseViewController {
    
    //MARK: - Properties
    
    private(set) var viewModel : NotePresentingViewModel
    
    public var savesHandler : ((NoteEntity)->())?
        
    //MARK: - Init
    
    init(viewModel: NotePresentingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNSAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textField.resignFirstResponder()
    }
    
    //MARK: - Overriding parent method
    override func navBarRightItemHandler() {
        updateText(in: viewModel.note)
    }
    
    //MARK: - UI object
    
    private var textField : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = R.Colors.background
        textView.textColor = R.Colors.black
        textView.font = UIFont.R.nunitoSans(size: 16, weight: .medium)
        textView.allowsEditingTextAttributes = true
        return textView
    }()
    
    //MARK: - Private methods
    public func configure(with note: NoteEntity) {
        let noteObject = Note.mapFromEntity(note)
        textField.text = noteObject.title + "\n" + noteObject.text
    }
  
    private func updateText(in note: NoteEntity) {
        guard let texti = textField.text, !texti.isEmpty else { return }
        let text = (texti as NSString)
        
        let title = textField.getFirstLine()
        let textWithoutTitle = textField.getTextWithoutTitle()
        
        let noteObject = Note.mapFromEntity(note)
        if noteObject.fullText == text as String {
            return
        } else if note.title != title {
            updateTitle(with: title)
        } else if note.text != text as String {
            updateText(with: textWithoutTitle, title: title)
        } else {
            print("Text \(textWithoutTitle)")
            #warning("Короче где-то тут косяк если делаю титл, а текст сразу не делаю")
        }
    }
    
    private func updateTitle(with title: String) {
        let note = Note(title: title, text: viewModel.note.text ?? "", date: Date.now, noteType: .daily, isFavorite: viewModel.note.isFavorite)
        let context = CoreDataManager.shared.mainContext

        let noteEntity = note.mapToEntityInContext(context)
        savesHandler?(noteEntity)
    }
    
    private func updateText(with text: String, title: String) {
        let numLines = textField.numberOfLines()
        let context = CoreDataManager.shared.mainContext
        if numLines < 2 {
            let note = Note(title: title, text: viewModel.note.text ?? "", date: Date.now, noteType: .daily, isFavorite: viewModel.note.isFavorite)
            let noteEntity = note.mapToEntityInContext(context)
            savesHandler?(noteEntity)
        } else if numLines > 2 {
            let note = Note(title: title, text: text, date: Date.now, noteType: .daily, isFavorite: viewModel.note.isFavorite)
            let noteEntity = note.mapToEntityInContext(context)
            savesHandler?(noteEntity)
        }
    }
    
    private func setNSAttributes() {
        guard let text = textField.text, !text.isEmpty else { return }
        let title = textField.getFirstLine()
        let attributedText = NSMutableAttributedString(string: text)

        let titleRange = (text as NSString).range(of: title)
        attributedText.addAttribute(.font, value: UIFont.R.nunitoSans(size: 20, weight: .bold) as Any, range: titleRange)

        
        let restOfText = textField.getTextWithoutTitle()
        let restOfTextRange = (text as NSString).range(of: restOfText)
        attributedText.addAttribute(.font, value: UIFont.R.nunitoSans(size: 17, weight: .medium) as Any, range: restOfTextRange)

        textField.attributedText = attributedText
        
    }
}

extension NotePresentingViewController {
    
    override func configureView() {
        super.configureView()
        textField.tintColor = R.Colors.active
        
    }
    
    override func addSubviews() {
        view.addSubview(textField)

        addNavBarItem(at: .right(type: .button), title: R.Strings.Buttons.save)
        navigationItem.backButtonTitle = R.Strings.Buttons.notes
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

extension NotePresentingViewController: UITextViewDelegate {
   

}
