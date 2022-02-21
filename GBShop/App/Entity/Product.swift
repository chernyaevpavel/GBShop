//
//  Product.swift
//  GBShop
//
//  Created by Павел Черняев on 24.01.2022.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let price: Float
    
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "product_name"
        case price = "price"
    }
}
