//
//  BaseViewController.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        addSubviews()
        layoutConstraints()
    }

    private lazy var backButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(R.Colors.inActive, for: .disabled)
        button.titleLabel?.font = UIFont.R.nunitoSans(size: 10, weight: .medium)
        return button
    } ()
    
    private lazy var nextButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(R.Colors.inActive, for: .disabled)
        button.titleLabel?.font = UIFont.R.nunitoSans(size: 10, weight: .medium)
        return button
    }()
    
    private var titleLabel : UILabel = {
        let title = UILabel()
        title.font = UIFont.R.nunitoSans(size: 20, weight: .bold)
        title.textColor = R.Colors.black
        return title
    } ()

}

@objc extension BaseViewController {
    
    func configureView() {
        view.backgroundColor = R.Colors.background
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

enum NavBarPosition {
    case left(type: NavBarItemType)
    case right(type: NavBarItemType)
    case center
}

enum NavBarItemType {
    case button
    case label
}

extension BaseViewController {
    
    func addNavBarItem(at position: NavBarPosition, title : String? = nil) {

        switch position {
        case .left(let type):
            
            switch type {
            case .button:
                backButton.addTarget(self, action: #selector(navBarLeftItemHandler), for: .touchUpInside)
                backButton.setTitle(title, for: .normal)
                navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
            case .label:
                titleLabel.text = title
                navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
            }
            
        case .right:
            nextButton.addTarget(self, action: #selector(navBarRightItemHandler), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextButton)
            
        case .center:
            navigationItem.title = title
        }
    }
}


