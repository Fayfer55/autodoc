//
//  SceneDelegate.swift
//  autodoc
//
//  Created by Kirill Faifer on 06.08.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // MARK: - Lifecycle

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let viewController = NewsFactory.makeNewsModule(device: scene.traitCollection.userInterfaceIdiom)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
    }

}

