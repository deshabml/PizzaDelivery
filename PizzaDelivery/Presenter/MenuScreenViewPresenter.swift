//
//  MenuScreenViewPresenter.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 13.01.2024.
//

import Foundation
import UIKit
import RealmSwift

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
    private let queueForRealm = DispatchQueue(label: "Queue for Realm", qos: .default)
    var realmSevice: RealmService?

    init() {
        self.getOfflineData()
        self.getCities()
        self.getCategorys()
        self.getDishes()
        self.saveImageData()
    }

    func getOfflineData() {
        queueForRealm.sync {
            self.realmSevice = RealmService()
            if let realmSevice {
                let realmCitys = realmSevice.getCitys()
                if !realmCitys.isEmpty {
                    self.cities = realmCitys
                    let realmCategorys = realmSevice.getCategorys()
                    if !realmCategorys.isEmpty {
                        categorys = realmCategorys[0]
                        let realmDishes = realmSevice.getDishes()
                        if !realmDishes.isEmpty {
                            dishes = realmDishes[0]
                            self.images = []
                            for _ in 0 ..< dishes.dishes.count {
                                guard let image = UIImage(systemName: "square.dashed") else { break }
                                self.images.append(image)
                            }
                        }
                        let imagesRealm = realmSevice.getImages()
                        if !imagesRealm.isEmpty {
                            if self.images.count == imagesRealm[0].images.count {
                                for index in 0 ..< imagesRealm[0].images.count {
                                    let image = UIImage(data: imagesRealm[0].images[index])
                                    if let image {
                                        self.images[index] = image
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    func getCities() {
        Task {
            do {
                let cities = try await NetworkServiceAA.shared.getData(dataset: [City()])
                await MainActor.run {
                    self.cities = cities
                    completion?()
                    queueForRealm.sync {
                        if let realmSevice {
                            let realmCities = realmSevice.getCitys()
                            if realmCities.isEmpty {
                                for city in cities {
                                    realmSevice.createObject(object: city)
                                }
                            }
                        }
                    }
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
                    queueForRealm.sync {
                        if let realmSevice {
                            let realmCategorys = realmSevice.getCategorys()
                            if realmCategorys.isEmpty {
                                realmSevice.createObject(object: Categorys(categoriesList: categorys.categories))
                            } else {
                                realmSevice.updateObject(oldObject: realmCategorys[0],
                                                         newObject: Categorys(categoriesList: categorys.categories))
                            }
                        }
                    }
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
                    self.images = []
                    for _ in 0 ..< dishes.dishes.count {
                        guard let image = UIImage(systemName: "square.dashed") else { break }
                        self.images.append(image)
                    }
                    self.getImages()
                    completion?()
                    queueForRealm.sync {
                        if let realmSevice {
                            let realmDishes = realmSevice.getDishes()
                            if realmDishes.isEmpty {
                                realmSevice.createObject(object: Dishes(dishesList: dishes.dishes))
                            } else {
                                realmSevice.updateObject(oldObject: realmDishes[0],
                                                         newObject: Dishes(dishesList: dishes.dishes))
                            }
                        }
                    }
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

    func saveImageData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [unowned self] in
            var imagesData: [Data] = []
            for image in images {
                let data = image.pngData()
                if let data {
                    imagesData.append(data)
                }
            }
            self.queueForRealm.sync {
                if let realmSevice = self.realmSevice {
                    let realmDishes = realmSevice.getImages()
                    if realmDishes.isEmpty {
                        realmSevice.createObject(object: Images(imagesArray: imagesData))
                    } else {
                        realmSevice.updateObject(oldObject: realmDishes[0],
                                                 newObject: Images(imagesArray: imagesData))
                    }
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
