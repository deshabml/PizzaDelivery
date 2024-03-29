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
    private let server = Server.prod

    private init() { }

    func createUrl(endpoint: EndPoint) -> URL? {
        let urlStr = tunnel + server.rawValue + endpoint.rawValue
        return URL(string: urlStr)
    }
}

enum Server: String {

    case prod = "run.mocky.io"
}

enum EndPoint: String {

    case city = "/v3/d3671f3f-4eb4-48f7-82b2-0ea6fb22feae"
    case category = "/v3/5bc499d6-0804-4050-9c9d-d0f719c67c8a"
    case dishes = "/v3/4d8375ca-16f8-46c8-b9a9-7cc483564591"
}
