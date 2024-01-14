//
//  RealmService.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 14.01.2024.
//

import Foundation
import RealmSwift

class RealmService {

    private let dataBase: Realm = try! Realm()

    init() { }

    func createObject<T>(object: T) {
        guard let object = object as? Object else { return }
        do {
            try dataBase.write {
                dataBase.add(object)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }

    func updateObject<T>(oldObject: T, newObject: T) {
        if let oldObject = oldObject as? Categorys, let newObject = newObject as? Categorys {
            do {
                try dataBase.write {
                    oldObject.categories = newObject.categories
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        if let oldObject = oldObject as? Dishes, let newObject = newObject as? Dishes {
            do {
                try dataBase.write {
                    oldObject.dishes = newObject.dishes
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        if let oldObject = oldObject as? Images, let newObject = newObject as? Images {
            do {
                try dataBase.write {
                    oldObject.images = newObject.images
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func deleteObject<T>(object: T) {
        guard let object = object as? Object else { return }
        do {
            try dataBase.write {
                dataBase.delete(object)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }

    func getCitys() -> [City] {
        let cityList = dataBase.objects(City.self)
        var citys = [City]()
        for city in cityList {
            citys.append(city)
        }
        return citys
    }

    func getCategorys() -> [Categorys] {
        let categorysList = dataBase.objects(Categorys.self)
        var categorysArray = [Categorys]()
        for categorys in categorysList {
            categorysArray.append(categorys)
        }
        return categorysArray
    }

    func getDishes() -> [Dishes] {
        let dishesList = dataBase.objects(Dishes.self)
        var dishesArray = [Dishes]()
        for dishes in dishesList {
            dishesArray.append(dishes)
        }
        return dishesArray
    }

    func getImages() -> [Images] {
        let imagesList = dataBase.objects(Images.self)
        var imagesArray = [Images]()
        for images in imagesList {
            imagesArray.append(images)
        }
        return imagesArray
    }
}
