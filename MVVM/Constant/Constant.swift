//
//  Constant.swift
//  MVVM
//
//  Created by SMIT iMac27 on 17/05/24.
//


enum Constant {
    enum API {
        static let productURl = "https://fakestoreapi.com/products"
    }
}

enum DataError : Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}
