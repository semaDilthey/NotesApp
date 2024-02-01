//
//  SceneDelegate.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 26.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let notesController = NotesViewController(viewModel: NotesViewModel(dataStorage: DataStorage()))
        var rootController = BaseNavController()
        
        if Core.shared.isNewUser() {
            rootController = BaseNavController(rootViewController: OnboardingPageController())
            rootController.isNavigationBarHidden = true
            window?.rootViewController = rootController
            CoreDataManager.shared.resetAllCoreData()
        } else {
            rootController = BaseNavController(rootViewController: notesController)
            window?.rootViewController = rootController
        }
        window?.makeKeyAndVisible()
       
    }

    func sceneDidDisconnect(_ scene: UIScene) {
   
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

