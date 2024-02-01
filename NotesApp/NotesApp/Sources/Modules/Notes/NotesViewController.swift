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
   
        viewModel.fetchNotes { [weak self] in
            self?.collectionView.reloadData()
        }
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
        
        viewModel.notesCallback {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.viewModel.getNotesCount() == 0 ? (self.warningLabel.isHidden = false) : (self.warningLabel.isHidden = true)
            }
            
        }
        Core.shared.setIsNotNewUser()
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
        label.text = R.Strings.Labels.noNotes
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
        
        viewModel.getNotesCount() == 0 ? (collectionView.isHidden = true) : (warningLabel.isHidden = true)
    }
    
    override func navBarRightItemHandler() {
        let vc = viewModel.getCreatingController()
        
        vc.completionHandler = { [weak self] note in
            guard let self else { return }
            self.viewModel.saveNote(note)
            vc.dismiss(animated: true)
        }
        present(vc, animated: true)
    }
    
    @objc func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        guard let indexPath = collectionView.indexPathForItem(at: gestureRecognizer.location(in: collectionView)) else {
            return
        }
        let cell = collectionView.cellForItem(at: indexPath)
//        
        UIView.animate(withDuration: 0.3) {
            cell?.contentView.backgroundColor = .red.withAlphaComponent(0.5)
            cell?.contentView.frame.origin = CGPoint(x: +8, y: -8)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                cell?.contentView.backgroundColor = R.Colors.setRandomColor()
                cell?.contentView.frame.origin = CGPoint(x: 0, y: 0)
            }
            
        }

        let alertController = UIAlertController(title: "Вы действительно хотите удалить записку?", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отменить" , style: .cancel)
        let apply = UIAlertAction(title: "Удалить", style: .default) {_ in 
            self.viewModel.deleteNote(at: indexPath.row)
        }
        alertController.addAction(cancel)
        alertController.addAction(apply)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        self.present(alertController, animated: true)
    }
}

//MARK: - Parent methods overriding

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
        addNavBarItem(at: .left(type: .label), title: R.Strings.Labels.myNotes)
        addNavBarItem(at: .right(type: .button), title: R.Strings.Buttons.add)
        view.addSubview(collectionView)
        view.addSubview(warningLabel)
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension NotesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNotesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCell.identifier, for: indexPath) as! NotesCell
        if let note = viewModel.getNote(at: indexPath) {
            cell.configure(with: note)
            
            cell.addToFavorites = { isFavorite in
                self.viewModel.addToFav(note, at: indexPath, isFav: isFavorite)
                print("Is favorite? See: \(isFavorite) at index \(indexPath.row)")
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let vc = viewModel.getEditingController(at: indexPath.row) else { return }
        vc.savesHandler = { note in
            self.viewModel.updateNote(note, at: indexPath)
            self.navigationController?.pushViewController(NotesViewController(viewModel: self.viewModel), animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .right
            cell.addGestureRecognizer(swipeGesture)
    }
}

