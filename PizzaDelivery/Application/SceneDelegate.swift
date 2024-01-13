//
//  SceneDelegate.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 13.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: winScene)
        window.overrideUserInterfaceStyle = .light
        window.rootViewController = ModelBuilder.createMainScreen()
        window.makeKeyAndVisible()
        self.window = window    }

}

