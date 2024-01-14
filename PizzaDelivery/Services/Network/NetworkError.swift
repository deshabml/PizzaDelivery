//
//  NetworkError.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 13.01.2024.
//

enum NetworkError: Error {

    case badUrl
    case badResponse
    case invalidDecoding
    case noImage
}
