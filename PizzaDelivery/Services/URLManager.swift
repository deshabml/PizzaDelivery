//
//  URLManager.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 13.01.2024.
//

import Foundation

final class URLManager {

    static let shared = URLManager()
    private let tunnel = "https://"

    private init() { }

    func createUrl(endpoint: EndPoint) -> URL? {
        let urlStr = tunnel + endpoint.rawValue
        return URL(string: urlStr)
    }
}

enum EndPoint: String {

    case city = "github.com/pensnarik/russian-cities/blob/master/russian-cities.json"
}
