//
//  LoginBussinesModel.swift
//  GBShop
//
//  Created by Павел Черняев on 13.02.2022.
//

import Foundation
import Alamofire

class LoginBussinesModel: NetworkModel {

    private let requestFactory = RequestFactory()
    
    func send(_ loginFunction: LoginFunction, completion: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let loginRequestFactory = self.requestFactory.makeLoginRequestFactory()
        
        switch loginFunction {
        case .login:
            loginRequestFactory.login(userName: "Somebody", password: "mypassword", completionHandler: completion)
        }
    }
}
