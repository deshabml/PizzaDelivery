//
//  Dish.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 14.01.2024.
//

import Foundation

struct Dish: Decodable {

    let id: Int
    let groupId: Int
    var name: String
    var price: Int
    var description: String
    var imageUrl: String
}

struct Dishes: Decodable {

    var dishes: [Dish]
}
