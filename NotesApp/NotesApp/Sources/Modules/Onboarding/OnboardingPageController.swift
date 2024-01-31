//
//  OnboardingPageController.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import UIKit

class OnboardingPageController: UIPageViewController {
    
    var pages = [OnboardingController]()

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addSubviews()
        layoutConstraints()

        for page in pages {
            page.delegate = self
        }
    }
        
    private var progressView : UIView = UIView()
    private var progressIndicator : UIView = UIView()
    
    private var pageControl = UIPageControl()
    private let initialPage = 0
    private var currentPage = 0
    
    private func updateIndicatorPosition() {
        let newPositionX = CGFloat(Float(currentPage)) * progressIndicator.frame.width
        UIView.animate(withDuration: 0.4) {
            self.progressIndicator.transform = CGAffineTransform(translationX: newPositionX, y: 0)
        }
      }

}


extension OnboardingPageController {
    
    private func configureView() {
        
        progressView.backgroundColor = R.Colors.grey
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 2
        
        progressIndicator.backgroundColor = R.Colors.active
        progressIndicator.clipsToBounds = true
        progressIndicator.layer.cornerRadius = 2
                
        pageControl.currentPageIndicatorTintColor = R.Colors.active
        pageControl.pageIndicatorTintColor = R.Colors.grey
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        pages = OnboardingControllers.allCases.map {
            let controller = OnboardingController(image: R.Images.Onboarding.image(for: $0), 
                                                  title: R.Strings.Onboarding.Titles.title(for: $0),
                                                  subtitle: R.Strings.Onboarding.Subtitles.subtitle(for: $0),
                                                  buttonTitle: R.Strings.Onboarding.Buttons.buttonText(for: $0))
            
            return controller
        }
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(pageControl)
        view.addSubview(progressView)
        progressView.addSubview(progressIndicator)
    }
    
    private func layoutConstraints() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            progressView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -335),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            progressView.heightAnchor.constraint(equalToConstant: 3),
            
            progressIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -335),
            progressIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressIndicator.widthAnchor.constraint(equalToConstant: 120),
            progressIndicator.heightAnchor.constraint(equalToConstant: 3),
        ])
    }
}

extension OnboardingPageController : OnboardingControllerDelegate {
    
    func didTapNextButton() {
        if currentPage < pages.count - 1 {
            let nextIndex = currentPage + 1
            setViewControllers([pages[nextIndex]], direction: .forward, animated: true, completion: nil)
            currentPage = nextIndex
            updateIndicatorPosition()
        } else {
            print("Последняя страница")
            AppDelegate().setIsNotNewUser()
            let vc = NotesViewController(viewModel: NotesViewModel(dataStorage: DataStorage()))
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

