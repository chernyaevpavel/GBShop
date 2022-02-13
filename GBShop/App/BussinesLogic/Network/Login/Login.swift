//
//  Login.swift
//  GBShop
//
//  Created by Павел Черняев on 13.02.2022.
//

import Foundation
import Alamofire

class Login: AbstactRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseURL = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Login: LoginRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseURL: baseURL, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Login {
    struct Login: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "login.json"
        let login: String
        let password: String
        var parameters: Parameters? {
            return ["username": login, "password": password]
        }
    }
}
