//
//  MenuScreenViewPresenter.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 13.01.2024.
//

import Foundation

protocol MenuScreenViewProtocol {

    func setContent(mainModel: MenuModel)
}

protocol MenuScreenViewPresenterProtocol {

    init(view: MenuScreenViewProtocol, mainModel: MenuModel)

    func showContent(completion: @escaping () -> ())
}

class MenuScreenPresenter: MenuScreenViewPresenterProtocol {

    let view: MenuScreenViewProtocol
    let mainModel: MenuModel

    required init(view: MenuScreenViewProtocol, mainModel: MenuModel) {
        self.view = view
        self.mainModel = mainModel
    }

    func showContent(completion: @escaping () -> ()) {
        view.setContent(mainModel: mainModel)
    }
}

final class MenuModel {

   

}
