//
//  ProductList.swift
//  GBShop
//
//  Created by Павел Черняев on 24.01.2022.
//

import Foundation
import Alamofire

class ProductList: AbstactRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    let baseURL = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension ProductList: ProductRequestFctory {
    func getProductList(page: Int, category: Int, completion: @escaping (AFDataResponse<[Product]>) -> Void) {
        let requestModel = GetProductList(baseURL: baseURL, page: page, category: category)
        self.request(request: requestModel, completionHandler: completion)
    }
}

extension ProductList {
    struct GetProductList: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"
        let page: Int
        let category: Int
        var parameters: Parameters? {
            return ["page_number": page, "id_category": category]
        }
    }
}
