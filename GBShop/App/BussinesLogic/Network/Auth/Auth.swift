//
//  Auth.swift
//  GBShop
//
//  Created by Павел Черняев on 20.01.2022.
//

import Foundation
import Alamofire

class Auth: AbstactRequestFactory {
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

extension Auth: AuthRequestFactory {
    
    func logout(userID: String, completionHandler: @escaping (AFDataResponse<ResponseResult>) -> Void) {
        let requestModel = Logout(baseURL: baseURL, userID: userID)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func registry(userID: String, userName: String, password: String, email: String, completionHandler: @escaping (AFDataResponse<ResponseResult>) -> Void) {
        let requestModel = Registry(baseURL: baseURL,
                                    userID: userID,
                                    login: userName,
                                    password: password,
                                    email: email)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeUserData(userID: String, userName: String, password: String, email: String, completionHandler: @escaping (AFDataResponse<ResponseResult>) -> Void) {
        let requestModel = ChangeUserData(baseURL: baseURL,
                                          userID: userID,
                                          login: userName,
                                          password: password,
                                          email: email)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension Auth {
    
    struct Logout: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        let userID: String
        var parameters: Parameters? {
            return ["id_user": userID]
        }
    }
    
    struct Registry: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"
        let userID: String
        let login: String
        let password: String
        let email: String
        
        var parameters: Parameters? {
            return ["id_user": userID,
                    "username": login,
                    "password": password,
                    "email": email
            ]
        }
    }
    
    struct ChangeUserData: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"
        let userID: String
        let login: String
        let password: String
        let email: String
        
        var parameters: Parameters? {
            return ["id_user": userID,
                    "username": login,
                    "password": password,
                    "email": email
            ]
        }
    }
}
