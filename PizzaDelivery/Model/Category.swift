//
//  Category.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 14.01.2024.
//

import Foundation

struct Category: Decodable {

    let id: Int
    var name: String
}

struct Categorys: Decodable {

    var categories: [Category]
}
