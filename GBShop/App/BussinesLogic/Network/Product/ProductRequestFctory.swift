//
//  ProductRequestFctory.swift
//  GBShop
//
//  Created by Павел Черняев on 24.01.2022.
//

import Foundation
import Alamofire

protocol ProductRequestFctory {
    func getProductList(page: Int, category: Int, completion: @escaping (AFDataResponse<[Product]>) -> Void)
}
