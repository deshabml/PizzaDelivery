//
//  Category.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 14.01.2024.
//

import Foundation
import RealmSwift

final class Category: Object, Decodable {

    @Persisted var id: Int
    @Persisted var name: String

    convenience init(id: Int, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}

final class Categorys: Object, Decodable {

    @Persisted(primaryKey: true) var id: String?
    @Persisted var categories: List<Category>

    convenience init(categoriesList: List<Category>) {
        self.init()
        self.id = UUID().uuidString
        self.categories = categoriesList
    }

    convenience init(categoriesArray: [Category]) {
        self.init()
        self.id = UUID().uuidString
        self.categories.append(objectsIn: categoriesArray)
    }
}
