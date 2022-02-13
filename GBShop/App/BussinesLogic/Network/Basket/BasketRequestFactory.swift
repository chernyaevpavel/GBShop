//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Павел Черняев on 05.02.2022.
//

import Foundation
import Alamofire

protocol BasketRequestFactory {
    func addToBasket(idProduct: Int, quantity: Int, completion: @escaping (AFDataResponse<ResponseResult>) -> Void)
    func deleteFromBasket(idProduct: Int, completion: @escaping (AFDataResponse<ResponseResult>) -> Void)
    func payBasket()
}
