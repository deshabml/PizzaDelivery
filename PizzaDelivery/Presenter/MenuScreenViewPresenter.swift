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
        mainModel.setupCompletion(completion: completion)
        view.setContent(mainModel: mainModel)
    }
}

final class MenuModel {

    var cities: [City] = []
    var selectedCity = "Москва"
    private var completion: (() -> ())?
    let bannersImageName = ["BannerImage",
                            "BannerImage",
                            "BannerImage",
                            "BannerImage",
                            "BannerImage"]
    var categorys: Categorys = Categorys(categories: [])
    var selectedCategoryID = 1

    init() {
        getCities()
        getCategorys()
    }

    func getCities() {
        Task {
            do {
                let cities = try await NetworkServiceAA.shared.getData(dataset: [City.ClearCity])
                await MainActor.run {
                    self.cities = cities
                    completion?()
                }
            } catch {
                print(error)
            }
        }
    }

    func getCategorys() {
        Task {
            do {
                let categorys = try await NetworkServiceAA.shared.getData(dataset: categorys)
                await MainActor.run {
                    self.categorys = categorys
                    if !categorys.categories.isEmpty {
                        self.selectedCategoryID = categorys.categories[0].id
                    }
                    completion?()
                }
            } catch {
                print(error)
            }
        }
    }

    func setupCompletion(completion: @escaping () -> ()) {
        self.completion = completion
    }

    func setupSelectedCity(_ nameCity: String) {
        selectedCity = nameCity
    }

    func setupSelectedCategoryID(_ id: Int) {
        selectedCategoryID = id
    }
}
