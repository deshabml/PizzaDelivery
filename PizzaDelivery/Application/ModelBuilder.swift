//
//  ModelBuilder.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 13.01.2024.
//

import UIKit

protocol Builder {

    static func createMainScreen() -> UIViewController

}

class ModelBuilder: Builder {

    static func createMainScreen() -> UIViewController {
        createTabBar()
    }

    private static func createMenuController() -> UINavigationController {
        let mainModel = MenuModel()
        let view = MenuViewController()
        let presenter = MenuScreenPresenter(view: view, mainModel: mainModel)
        view.presenter = presenter
        let mvc = UINavigationController(rootViewController: view)
        mvc.tabBarItem = UITabBarItem(title: "Меню", image: UIImage(named: "MenuImage"), tag: 0)
        return mvc
    }

    private static func createContactsController() -> UINavigationController {
        let view = ContactsViewController()
        let svc = UINavigationController(rootViewController: view)
        svc.tabBarItem = UITabBarItem(title: "Контаты", image: UIImage(named: "СontactsImage"), tag: 1)
        return svc
    }

    private static func createProfileController() -> UINavigationController {
        let view = ProfileViewController()
        let cvc = UINavigationController(rootViewController: view)
        cvc.tabBarItem = UITabBarItem(title: "Пофиль", image: UIImage(named: "ProfileImage"), tag: 2)
        return cvc
    }

    private static func createCartController() -> UINavigationController {
        let avc = UINavigationController(rootViewController: CartViewController())
        avc.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(named: "CartImage"), tag: 3)
        return avc
    }

    private static func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [createMenuController(),
                                  createContactsController(),
                                  createProfileController(),
                                  createCartController()]
        tabBar.tabBar.backgroundColor = .white
        let borderView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.tabBar.bounds.width, height: 1))
        borderView.backgroundColor = UIColor(named: "TabBarGrayColor")
        tabBar.tabBar.addSubview(borderView)
        tabBar.tabBar.unselectedItemTintColor = UIColor(named: "TabBarGrayColor")
        tabBar.tabBar.tintColor = UIColor(named: "TabBarActiveColor")
        tabBar.tabBar.selectedItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)], for: .normal)
        tabBar.selectedIndex = 0
        return tabBar
    }
}
