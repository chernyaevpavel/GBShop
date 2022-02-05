//
//  RequestFactory.swift
//  GBShop
//
//  Created by Павел Черняев on 20.01.2022.
//

import Foundation
import Alamofire

class RequestFactory {
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFactory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeProductListRequestFactory() -> ProductRequestFctory {
        let errorParser = makeErrorParser()
        return ProductList(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeReviewRequestFactory() -> ReviewRequestFactory {
        let errorParser = makeErrorParser()
        return Review(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeBasketRequestFactory() -> BasketRequestFactory {
        let errorParser = makeErrorParser()
        return Basket(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}
