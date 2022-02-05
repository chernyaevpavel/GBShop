//
//  Basket.swift
//  GBShop
//
//  Created by Павел Черняев on 05.02.2022.
//

import Foundation
import Alamofire

class Basket: AbstactRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    let baseURL = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    var productList: [Int: Int] = [:]
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Basket: BasketRequestFactory {
    func addToBasket(idProduct: Int, quantity: Int, completion: @escaping (AFDataResponse<ResponseResult>) -> Void) {
        let requestModel = AddToBasket(baseURL: baseURL, idProduct: idProduct, quantity: quantity)
        self.request(request: requestModel, completionHandler: completion)
        productList[idProduct] = quantity
    }
    
    func deleteFromBasket(idProduct: Int, completion: @escaping (AFDataResponse<ResponseResult>) -> Void) {
        let requestModel = DeleteFromBasket(baseURL: baseURL, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completion)
        productList[idProduct] = nil
    }
    
    func payBasket() {
        productList.forEach { idProduct, _ in
            deleteFromBasket(idProduct: idProduct) { result in
                print("delete product \(idProduct) result \(result)")
            }
        }
        productList = [:]
    }
}

extension Basket {
    
    struct AddToBasket: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "addReview.json"
        let idProduct: Int
        let quantity: Int
        var parameters: Parameters? {
            return ["id_product": idProduct, "quantity": quantity]
        }
    }
    
    struct DeleteFromBasket: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "addReview.json"
        let idProduct: Int
        var parameters: Parameters? {
            return ["id_product": idProduct]
        }
    }
}


