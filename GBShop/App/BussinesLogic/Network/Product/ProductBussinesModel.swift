//
//  ProductBussinesModel.swift
//  GBShop
//
//  Created by Павел Черняев on 11.02.2022.
//

import Foundation
import Alamofire

class ProductBussinesModel: NetworkModel {
    
    private let requestFactory = RequestFactory()
    
    func send(_ producFunction: ProductFunction, completion: @escaping (AFDataResponse<[Product]>) -> Void) {
        let productRequestFactory = self.requestFactory.makeProductListRequestFactory()
        
        switch producFunction {
        case .getProductList:
            productRequestFactory.getProductList(page: 1, category: 1, completion: completion)
        }
    }
}

