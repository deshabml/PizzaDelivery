//
//  MenuViewController.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 13.01.2024.
//

import UIKit

final class MenuViewController: UIViewController {

    var presenter: MenuScreenViewPresenterProtocol!
    private let mainView: MenuView = MenuView()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showContent {
            self.mainView.cityTabelView.reloadData()
            self.mainView.categoriesCollectionView.reloadData()
        }
    }
}

extension MenuViewController: MenuScreenViewProtocol {

    func setContent(mainModel: MenuModel) {
        mainView.setContent(mainModel: mainModel)
        view = mainView
    }
}
