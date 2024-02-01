//
//  OnboardingController.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import Foundation
import UIKit

enum OnboardingControllers : Int, CaseIterable {
    case first
    case second
    case third
}

protocol OnboardingControllerDelegate: AnyObject {
    func didTapNextButton()
}

class OnboardingController : BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    weak var delegate: OnboardingControllerDelegate?
    
    private var image : UIImageView = UIImageView()
    private var titleLabel : UILabel = UILabel()
    private var subtitle : UILabel = UILabel()
    private var nextButton : UIButton = UIButton()
    private let lowerContainer : UIView = UIView()
    
    init(image: UIImage?, title: String?, subtitle: String?, buttonTitle: String?) {
        self.image.image = image
        self.titleLabel.text = title
        self.subtitle.text = subtitle
        self.nextButton.setTitle(buttonTitle, for: .normal)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTappedButton() {
        delegate?.didTapNextButton()
    }
}

extension OnboardingController {
    
    override func configureView() {
        view.backgroundColor = .white
        image.contentMode = .scaleAspectFit
        
        titleLabel.font = UIFont.R.nunitoSans(size: 25, weight: .bold)
        titleLabel.textColor = R.Colors.black
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        
        
        subtitle.font = UIFont.R.nunitoSans(size: 16, weight: .thin)
        subtitle.numberOfLines = 0
        subtitle.textColor = R.Colors.black
        subtitle.lineBreakMode = .byWordWrapping
        subtitle.textAlignment = .center
        
        nextButton.titleLabel?.font = UIFont.R.nunitoSans(size: 17, weight: .bold)
        nextButton.tintColor = R.Colors.white
        nextButton.backgroundColor = .red
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 11
        nextButton.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
        nextButton.animateTouch(nextButton)
        
        lowerContainer.backgroundColor = R.Colors.background
        lowerContainer.layer.cornerRadius = 20
        lowerContainer.clipsToBounds = true
    }
    
    override func addSubviews() {
        view.addSubview(image)
        view.addSubview(lowerContainer)

        lowerContainer.addSubview(nextButton)
    }
    
    override func layoutConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        lowerContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitle])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 10
        
        lowerContainer.addSubview(stack)
        
        NSLayoutConstraint.activate([
            lowerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lowerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lowerContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            lowerContainer.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.48),
            
            nextButton.bottomAnchor.constraint(equalTo: lowerContainer.bottomAnchor, constant: -56),
            nextButton.leadingAnchor.constraint(equalTo: lowerContainer.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: lowerContainer.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalTo: lowerContainer.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15),

            stack.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -24),
            stack.leadingAnchor.constraint(equalTo: lowerContainer.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: lowerContainer.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: lowerContainer.topAnchor, constant: 45),
            
            image.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            image.heightAnchor.constraint(equalToConstant: 250),
            image.widthAnchor.constraint(equalToConstant: 250)

            
        ])
    }
}
