//
//  BasketBussinesModel.swift
//  GBShop
//
//  Created by Павел Черняев on 11.02.2022.
//

import Foundation
import Alamofire

class BasketBussinesModel: NetworkModel {

    private let requestFactory = RequestFactory()
    
    func send(_ basketFunction: BasketFunction, completion: @escaping (AFDataResponse<ResponseResult>) -> Void) {
        let basketRequestFactory = self.requestFactory.makeBasketRequestFactory()
        
        switch basketFunction {
        case .addToBasket:
            let idProduct = 123
            let quantity = 5
            basketRequestFactory.addToBasket(idProduct: idProduct, quantity: quantity, completion: completion)
        case .deleteFromBasket:
            let idProduct = 123
            basketRequestFactory.deleteFromBasket(idProduct: idProduct, completion: completion)
        case .payBasket:
            basketRequestFactory.payBasket(completion: completion)
        }
    }
}
