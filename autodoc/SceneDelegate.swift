//
//  SceneDelegate.swift
//  autodoc
//
//  Created by Kirill Faifer on 06.08.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let viewCotroller = StartViewController()
        let navigationController = UINavigationController(rootViewController: viewCotroller)
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
    }

}

