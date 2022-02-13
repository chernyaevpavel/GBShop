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
    
    
    
    
    
    
    
    
    
    
    
    
    //    func send(_ producFunction: ProductFunction) -> Result<[Product], AFError> {
    //        let productRequestFactory = self.requestFactory.makeProductListRequestFactory()
    //
    //        switch producFunction {
    //        case .getProductList:
    //            productRequestFactory.getProductList(page: 1, category: 1) { response in
    //                return response.result
    //            }
    //
    //            //                switch response.result {
    //            //                case .success(let result):
    //            //                    print("result \(result)")
    //            //                case .failure(let error):
    //            //                    print(error.localizedDescription)
    //            //                }
    //        }
    //    }
}

