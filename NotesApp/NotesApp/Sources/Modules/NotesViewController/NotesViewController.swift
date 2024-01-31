//
//  NotesViewController.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import Foundation
import UIKit

class NotesViewController : BaseViewController {
    
    private(set) var viewModel : NotesViewModel
    
    init(viewModel: NotesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.fetchNotes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: R.Sizes.screenWidth/2-16-8, height: R.Sizes.screenHeight/4.5)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsMultipleSelection = true
        return collection
    }()
    
    private let warningLabel : UILabel = {
        let label = UILabel()
        label.text = "Нет записок"
        label.font = UIFont.R.nunitoSans(size: 20, weight: .bold)
        label.textColor = R.Colors.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(NotesCell.self, forCellWithReuseIdentifier: NotesCell.identifier)
        collectionView.backgroundColor = R.Colors.background
        
        if viewModel.getNotesCount() == 0 {
            collectionView.isHidden = true
        } else {
            warningLabel.isHidden = true
        }
    }
    
    override func navBarRightItemHandler() {
        let index = viewModel.getNotesCount()
        let vm = NoteCreatingViewModel(index: index)
        let vc = NoteCreatingViewController(viewModel: vm)
        vc.completionHandler = { note in
            self.viewModel.dataStorage.saveNote(note)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        present(vc, animated: true)
    }
    
}

extension NotesViewController {
    
    override func configureView() {
        super.configureView()
        configureCollectionView()
    }
    
    override func layoutConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            warningLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            warningLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    override func addSubviews() {
        addNavBarItem(at: .left(type: .label), title: "Мои записки")
        addNavBarItem(at: .right(type: .button), title: "Добавить")
        view.addSubview(collectionView)
        view.addSubview(warningLabel)
    }
    
}

extension NotesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNotesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCell.identifier, for: indexPath) as! NotesCell
        if let note = viewModel.getNote(at: indexPath) {
            cell.configure(with: note)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let note = viewModel.dataStorage.notes[indexPath.row]
        let vm = NotePresentingViewModel(note: note, index: indexPath.row)
        let vc = NotePresentingViewController(viewModel: vm)
        vc.configure(with: note)
        vc.title = note.title
        
        vc.savesHandler = { note in
            #warning("При изменении текста в изначальном варианте все меняется, но при перезагрузке получается, что CoreData не обновляет элемент, а старый оставляет прежний и сверху добавляет новый")
            self.viewModel.updateNote(note, at: indexPath)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

