//
//  Сity.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 13.01.2024.
//

import Foundation

struct City: Decodable {

    let coords: Coords
    let district: String
    let name: String
    let population: Int
    let subject: String

    struct Coords: Decodable {
        let lat: String
        let lon: String
    }

    static var ClearCity = City(coords: Coords(lat: "",
                                               lon: ""),
                                district: "",
                                name: "",
                                population: 0,
                                subject: "")
}
