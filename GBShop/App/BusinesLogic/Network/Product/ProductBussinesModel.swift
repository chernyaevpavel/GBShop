//
//  ProductBussinesModel.swift
//  GBShop
//
//  Created by Павел Черняев on 11.02.2022.
//

import Foundation

class ProductBussinesModel: NetworkModel {
    
    private let requestFactory = RequestFactory()
    
    func send(_ producFunction: ProductFunction) {
        let productRequestFactory = self.requestFactory.makeProductListRequestFactory()
        
        switch producFunction {
        case .getProductList:
            productRequestFactory.getProductList(page: 1, category: 1) { response in
                switch response.result {
                case .success(let result):
                    print("result \(result)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
