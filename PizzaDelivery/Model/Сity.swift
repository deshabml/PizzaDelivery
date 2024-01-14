//
//  Сity.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 13.01.2024.
//

import Foundation
import RealmSwift

final class City: Object, Decodable {

    @Persisted var coords: Coords?
    @Persisted var district: String
    @Persisted(primaryKey: true) var name: String
    @Persisted var population: Int
    @Persisted var subject: String

    convenience init(coords: Coords, district: String, name: String, population: Int, subject: String) {
        self.init()
        self.coords = coords
        self.district = district
        self.name = name
        self.population = population
        self.subject = subject
    }
}

final class Coords: Object, Decodable {

    @Persisted var lat: String
    @Persisted var lon: String

    convenience init(lat: String, lon: String) {
        self.init()
        self.lat = lat
        self.lon = lon
    }
}
