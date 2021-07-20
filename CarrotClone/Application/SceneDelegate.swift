//
//  SceneDelegate.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window: UIWindow = UIWindow(windowScene: scene)
        
        self.window = window
        let tabBar: UITabBarController = MainTabBarController()
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
}

