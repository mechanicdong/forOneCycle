//
//  SceneDelegate.swift
//  GitHubRepository
//
//  Created by 이동희 on 2022/03/28.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let rootViewController = RepositoryListViewController()
        let rootViewNavigationController = UINavigationController(rootViewController: rootViewController)
        
        self.window?.rootViewController = rootViewNavigationController
        self.window?.makeKeyAndVisible()
    }



}

