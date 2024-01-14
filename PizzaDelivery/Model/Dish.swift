//
//  Dish.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 14.01.2024.
//

import Foundation
import RealmSwift

final class Dish: Object, Decodable {

    @Persisted var id: Int
    @Persisted var groupId: Int
    @Persisted var name: String
    @Persisted var price: Int
    @Persisted var descriptionDish: String
    @Persisted var imageUrl: String

    convenience init(id: Int, groupId: Int, name: String, price: Int, description: String, imageUrl: String) {
        self.init()
        self.id = id
        self.groupId = groupId
        self.name = name
        self.price = price
        self.descriptionDish = description
        self.imageUrl = imageUrl
    }
}

final class Dishes: Object, Decodable {

    @Persisted(primaryKey: true) var id: String?
    @Persisted var dishes: List<Dish>

    convenience init(dishesList: List<Dish>) {
        self.init()
        self.id = UUID().uuidString
        self.dishes = dishesList
    }

    convenience init(dishesArray: [Dish]) {
        self.init()
        self.id = UUID().uuidString
        self.dishes.append(objectsIn: dishesArray)
    }
}
