//
//  ProductModel.swift
//  test2
//
//  Created by Refat E Ferdous on 11/28/23.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let productDescription: String
    let category: String
    let image: String
    let rating: Rating

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case productDescription = "description"
        case category, image, rating
    }
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}
