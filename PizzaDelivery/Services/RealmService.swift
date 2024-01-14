//
//  RealmService.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 14.01.2024.
//

import Foundation
import RealmSwift

class RealmService {

    static let shared = RealmService()
    private let dataBase = try! Realm()

    private init() { }

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

//    func getWeatherData() -> [WeatherData] {
//        let weatherDataList = dataBase.objects(WeatherData.self)
//        var weatherDatas = [WeatherData]()
//        for weatherData in weatherDataList {
//            weatherDatas.append(weatherData)
//        }
//        return weatherDatas
//    }

}
