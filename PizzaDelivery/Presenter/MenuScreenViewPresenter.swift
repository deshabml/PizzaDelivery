//
//  MenuScreenViewPresenter.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 13.01.2024.
//

import Foundation
import UIKit

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
    var categorys: Categorys = Categorys(categoriesArray: [])
    var selectedCategoryID = 1
    var dishes: Dishes = Dishes(dishesArray: [])
    var images: [UIImage] = []
    var selectedDishes: [(dish: Dish, image: UIImage)] {
        var selectedDishes: [(dish: Dish, image: UIImage)] = []
        for index in 0 ..< dishes.dishes.count {
            if dishes.dishes[index].groupId == selectedCategoryID {
                let dish = dishes.dishes[index]
                let image = images[index]
                selectedDishes.append((dish: dish, image: image))
            }
        }
        return selectedDishes
    }

    init() {
        getCities()
        getCategorys()
        getDishes()
    }

    func getCities() {
        Task {
            do {
                let cities = try await NetworkServiceAA.shared.getData(dataset: [City()])
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

    func getDishes() {
        Task {
            do {
                let dishes = try await NetworkServiceAA.shared.getData(dataset: dishes)
                await MainActor.run {
                    self.dishes = dishes
                    for _ in 0 ..< dishes.dishes.count {
                        guard let image = UIImage(systemName: "square.dashed") else { break }
                        self.images.append(image)
                    }
                    self.getImages()
                    completion?()
                }
            } catch {
                print(error)
            }
        }
    }

    private func getImages() {
        for index in 0 ..< dishes.dishes.count {
            Task {
                do {
                    let image = try await NetworkServiceAA.shared.downloadImage(url: dishes.dishes[index].imageUrl)
                    await MainActor.run {
                        self.images[index] = image
                        completion?()
                    }
                } catch {
                    print(error.localizedDescription)
                }
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
